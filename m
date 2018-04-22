Date: Sun, 22 Apr 2018 08:47:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: Correct support for MODULE_DEVICE_TABLE()
Message-ID: <20180422064758.GB16763@kroah.com>
References: <20180421235529.17243-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421235529.17243-1-afd@ti.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 21, 2018 at 06:55:29PM -0500, Andrew F. Davis wrote:
> Due to missing a missing entry in file2alias.c MODULE_DEVICE_TABLE() are
> not generating the proper module aliases. Add the needed entry here.
> 
> Reported-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  scripts/mod/devicetable-offsets.c |  3 +++
>  scripts/mod/file2alias.c          | 11 +++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> index 9fad6afe4c41..6667f7b491d6 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -139,6 +139,9 @@ int main(void)
>  	DEVID(hv_vmbus_device_id);
>  	DEVID_FIELD(hv_vmbus_device_id, guid);
>  
> +	DEVID(rpmsg_device_id);
> +	DEVID_FIELD(rpmsg_device_id, name);
> +
>  	DEVID(i2c_device_id);
>  	DEVID_FIELD(i2c_device_id, name);
>  

I don't understand, what caused this to break?  Has this ever worked?

> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index b9beeaa4695b..52fd54a8fe39 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -944,6 +944,17 @@ static int do_vmbus_entry(const char *filename, void *symval,
>  }
>  ADD_TO_DEVTABLE("vmbus", hv_vmbus_device_id, do_vmbus_entry);
>  
> +/* Looks like: rpmsg:S */
> +static int do_rpmsg_entry(const char *filename, void *symval,
> +			  char *alias)
> +{
> +	DEF_FIELD_ADDR(symval, rpmsg_device_id, name);
> +	sprintf(alias, RPMSG_DEVICE_MODALIAS_FMT, *name);
> +
> +	return 1;
> +}
> +ADD_TO_DEVTABLE("rpmsg", rpmsg_device_id, do_rpmsg_entry);

Is this just for this one specific bus type?  How far back does this
patch need to go?  How has no one noticed this before?

thanks,

greg k-h
