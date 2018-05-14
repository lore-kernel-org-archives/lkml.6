Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AB8JxZrCQKikx1vQMYUGsON65yOecGKod74Lv7+nTKXXfg5coN2eWP+as4sy9WEvy9W11dCxcZxf
ARC-Seal: i=1; a=rsa-sha256; t=1526288988; cv=none;
        d=google.com; s=arc-20160816;
        b=w7NwYURusHrOkW2JprSgt1yD0yX+QRX4d35DG7fDxdUyQvd6tbSwQHKXQgam5bo93b
         VlGmBcqQElwA5d4ZS4L/9EWfl0A//WU+KYtgRlj67mwpnol0e2q40roDZwRVm5fYJC8S
         K+MpicVrYlABwIMHnSpodSR71AzeMRuWKIO3AAOENIxxRGAfeMFwcv9cZ9HK2SP++Rtd
         vpsrwNxE6VHHuBY8pP4dB92Te7RyvEvLDfV6BSDRfBolkdv9OGlclnsF/wo4m3hPdJQR
         cM9saM2w7mKEk/z8jamVwadWl43SykoBbZ9ttqCWE3RHaP9sAAoqFtfXXeqNbo7ENrwo
         5AXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=L8qSwC/TKnY7MvKWntWoNfnmYXEBzWV3WFnCpl5AG9A=;
        b=AxXQiqcscTKKqkkDUArFFUyMNbrNTTE8CdIgpX2i2rv8oWUeJ3ANqhH8y4YNGPiMmz
         +kAJpz/nbTUCTSdV4YCpTE4vZkcpklJ413dxtOjfyz1Mc38fhfR7+i33glIpI114uLCR
         KQHCIo64kkzVXXXcIqL5ghKYocL/Dh8/zSWiP/W6ZdwT5zS1kvFD7VmWo9neHDhuSfsM
         MNHSW/0RQHkciFw9oLXZPkxUYp9UmNyBL5v3rIQiQselI9b6e1XA9jfBfMyend/e8j+w
         7cxlYM7eFmcmcU6WbaSRfllFWYHyD/VaM0IiPkRUo69yYq/qT2FQt1bex6nQYOMB2fKB
         z9oA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Mon, 14 May 2018 11:09:36 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4.16 41/72] mtd: rawnand: Make sure we wait tWB before
 polling the STATUS reg
Message-ID: <20180514110936.0497e59e@bbrezillon>
In-Reply-To: <20180514090422.GA25724@kroah.com>
References: <20180514064823.033169170@linuxfoundation.org>
	<20180514064824.942453369@linuxfoundation.org>
	<CAMuHMdW8cij2J64pCMeN=THP1h8WqX-eanyHQ70VsYVpERpFjA@mail.gmail.com>
	<20180514090422.GA25724@kroah.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600421798169787074?=
X-GMAIL-MSGID: =?utf-8?q?1600430002112026764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 14 May 2018 11:04:22 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, May 14, 2018 at 09:32:51AM +0200, Geert Uytterhoeven wrote:
> > On Mon, May 14, 2018 at 8:48 AM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:  
> > > 4.16-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > From: Boris Brezillon <boris.brezillon@bootlin.com>
> > >
> > > commit 3057fcef385348fe85173f1b0c824d89f1176f72 upstream.
> > >
> > > NAND chips require a bit of time to take the NAND operation into
> > > account and set the BUSY bit in the STATUS reg. Make sure we don't poll
> > > the STATUS reg too early in nand_soft_waitrdy().
> > >
> > > Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > ---
> > >  drivers/mtd/nand/nand_base.c |    5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > --- a/drivers/mtd/nand/nand_base.c
> > > +++ b/drivers/mtd/nand/nand_base.c
> > > @@ -707,12 +707,17 @@ static void nand_wait_status_ready(struc
> > >   */
> > >  int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
> > >  {
> > > +       const struct nand_sdr_timings *timings;
> > >         u8 status = 0;
> > >         int ret;
> > >
> > >         if (!chip->exec_op)
> > >                 return -ENOTSUPP;
> > >
> > > +       /* Wait tWB before polling the STATUS reg. */
> > > +       timings = nand_get_sdr_timings(&chip->data_interface);
> > > +       ndelay(PSEC_TO_NSEC(timings->tWB_max));
> > > +
> > >         ret = nand_status_op(chip, NULL);
> > >         if (ret)
> > >                 return ret;
> > >
> > >  
> > 
> > 
> > kbuild test robot via vger.kernel.org
> > Attachments1:36 PM (19 hours ago)
> > to Boris, kbuild-all, linux-kernel
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > master
> > head:   ccda3c4b77777f66aeb3c531352bb40d59501c59
> > commit: 3057fcef385348fe85173f1b0c824d89f1176f72 mtd: rawnand: Make
> > sure we wait tWB before polling the STATUS reg
> > date:   3 days ago
> > config: m68k-allyesconfig (attached as .config)
> > compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 3057fcef385348fe85173f1b0c824d89f1176f72
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=m68k
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/mtd/nand/raw/nand_base.o: In function `nand_soft_waitrdy':  
> > >> nand_base.c:(.text+0x1022): undefined reference to `__udivdi3'  
> 
> Ugh.  Does this also happen in Linus's tree?

Yes it does, unfortunately :-/. I posted a fix here [1].

[1]https://patchwork.kernel.org/patch/10396217/
