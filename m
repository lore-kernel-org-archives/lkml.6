Date: Sat, 17 Feb 2018 13:17:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Cc: gs051095@gmail.com, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: gdm724x: tty: Fix macro argument reuse that
 could cause side-effects.
Message-ID: <20180217121741.GC10940@kroah.com>
References: <20180216222655.23919-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216222655.23919-1-quytelda@tamalin.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 02:26:55PM -0800, Quytelda Kahja wrote:
> Fix a coding style warning from checkpatch.pl.  Use GNU extensions to create
> references to the results of problem macro arguments when they are evaluated so
> that they can be used safely multiple times.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index fc7682c18f20..73d39fa86d10 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -37,14 +37,22 @@
>  
>  #define MUX_TX_MAX_SIZE 2048
>  
> -#define gdm_tty_send(n, d, l, i, c, b) (\
> -	n->tty_dev->send_func(n->tty_dev->priv_dev, d, l, i, c, b))
> -#define gdm_tty_recv(n, c) (\
> -	n->tty_dev->recv_func(n->tty_dev->priv_dev, c))
> -#define gdm_tty_send_control(n, r, v, d, l) (\
> -	n->tty_dev->send_control(n->tty_dev->priv_dev, r, v, d, l))
> -
> -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> +#define gdm_tty_send(n, d, l, i, c, b)					\
> +	({ typeof(n) n_ = (n);						\
> +		void *priv_dev = n_->tty_dev->priv_dev;			\
> +		n_->tty_dev->send_func(priv_dev, d, l, i, c, b); })
> +#define gdm_tty_recv(n, c)					\
> +	({ typeof(n) n_ = (n);					\
> +		void *priv_dev = n_->tty_dev->priv_dev;		\
> +		n_->tty_dev->recv_func(priv_dev, c); })
> +#define gdm_tty_send_control(n, r, v, d, l)				\
> +	({ typeof(n) n_ = (n);						\
> +		void *priv_dev = n_->tty_dev->priv_dev;			\
> +		n_->tty_dev->send_control(priv_dev, r, v, d, l); })
> +
> +#define GDM_TTY_READY(gdm)						\
> +	({ typeof(gdm) gdm_ = gdm;					\
> +		gdm_ && gdm_->tty_dev && gdm_->port.count; })

Ugh, that's a mess.  How about just replacing the use of these odd
macros with the "real" call instead?  The fact that they are messing
around with the tty_dev call directly is really strange and should be
made a lot more obvious, as that probably needs to be fixed up.

thanks,

greg k-h
