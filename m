Date: Mon, 14 May 2018 11:04:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4.16 41/72] mtd: rawnand: Make sure we wait tWB before
 polling the STATUS reg
Message-ID: <20180514090422.GA25724@kroah.com>
References: <20180514064823.033169170@linuxfoundation.org>
 <20180514064824.942453369@linuxfoundation.org>
 <CAMuHMdW8cij2J64pCMeN=THP1h8WqX-eanyHQ70VsYVpERpFjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW8cij2J64pCMeN=THP1h8WqX-eanyHQ70VsYVpERpFjA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 09:32:51AM +0200, Geert Uytterhoeven wrote:
> On Mon, May 14, 2018 at 8:48 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > 4.16-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Boris Brezillon <boris.brezillon@bootlin.com>
> >
> > commit 3057fcef385348fe85173f1b0c824d89f1176f72 upstream.
> >
> > NAND chips require a bit of time to take the NAND operation into
> > account and set the BUSY bit in the STATUS reg. Make sure we don't poll
> > the STATUS reg too early in nand_soft_waitrdy().
> >
> > Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > ---
> >  drivers/mtd/nand/nand_base.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > --- a/drivers/mtd/nand/nand_base.c
> > +++ b/drivers/mtd/nand/nand_base.c
> > @@ -707,12 +707,17 @@ static void nand_wait_status_ready(struc
> >   */
> >  int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
> >  {
> > +       const struct nand_sdr_timings *timings;
> >         u8 status = 0;
> >         int ret;
> >
> >         if (!chip->exec_op)
> >                 return -ENOTSUPP;
> >
> > +       /* Wait tWB before polling the STATUS reg. */
> > +       timings = nand_get_sdr_timings(&chip->data_interface);
> > +       ndelay(PSEC_TO_NSEC(timings->tWB_max));
> > +
> >         ret = nand_status_op(chip, NULL);
> >         if (ret)
> >                 return ret;
> >
> >
> 
> 
> kbuild test robot via vger.kernel.org
> Attachments1:36 PM (19 hours ago)
> to Boris, kbuild-all, linux-kernel
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> head:   ccda3c4b77777f66aeb3c531352bb40d59501c59
> commit: 3057fcef385348fe85173f1b0c824d89f1176f72 mtd: rawnand: Make
> sure we wait tWB before polling the STATUS reg
> date:   3 days ago
> config: m68k-allyesconfig (attached as .config)
> compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 3057fcef385348fe85173f1b0c824d89f1176f72
>         # save the attached .config to linux build tree
>         make.cross ARCH=m68k
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/mtd/nand/raw/nand_base.o: In function `nand_soft_waitrdy':
> >> nand_base.c:(.text+0x1022): undefined reference to `__udivdi3'

Ugh.  Does this also happen in Linus's tree?

thanks,

greg k-h
