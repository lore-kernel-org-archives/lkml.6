Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEQNb5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:31:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39511 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEQNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:31:55 -0400
X-Google-Smtp-Source: AB8JxZoRSH1SwOQK6Tc9lwZk2ePoOWHBRduFbODcn2UynpV6w0zhbMCG61Q1vBIkayhyvtn4lph2sA==
Date: Thu, 17 May 2018 14:31:51 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jason Wessel <jason.wessel@windriver.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] misc: kgdbts: silence array underflow warning
Message-ID: <20180517133151.tzdkkomabejupex7@holly.lan>
References: <20180517122229.GA7655@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517122229.GA7655@mwanda>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 03:22:29PM +0300, Dan Carpenter wrote:
> Smatch distrusts simple_strtol().  I don't know the code well enough
> to say if the distrust is justified here, but it seems harmless to
> silence the warning.

What warning does this fix? I'd prefer to have it in the description.


> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
> index 6193270e7b3d..e0508acaedaa 100644
> --- a/drivers/misc/kgdbts.c
> +++ b/drivers/misc/kgdbts.c
> @@ -400,13 +400,15 @@ static void skip_back_repeat_test(char *arg)
>  	int go_back = simple_strtol(arg, NULL, 10);

If go_back is out of range then this is a serious error in the test
plans found in the module. Something simple and clear such as
BUG_ON(go_back <= 0 || go_back > ts.idx) is probably sufficient.


>  	repeat_test--;
> -	if (repeat_test <= 0) {
> +	if (repeat_test <= 0 || go_back < 0) {

The BUG_ON() will mess things up because whatever breakpoints
the test is using are still enabled.

If you really want to recover cleanly then perhaps:

+	if (repeat_test <= 0 || WARN_ON(go_back < 0 || go_back > ts.idx)) {


>  		ts.idx++;
>  	} else {
>  		if (repeat_test % 100 == 0)
>  			v1printk("kgdbts:RUN ... %d remaining\n", repeat_test);
>  
>  		ts.idx -= go_back;
> +		if (ts.idx < 0)
> +			ts.idx = 0;

Not sure about this. If we know the opcodes are bad then re-executing
them doesn't seem like a good idea (hence covering it in the WARN_ON
branch above).


Daniel.
