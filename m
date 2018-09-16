Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928ACECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4862F2086E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4862F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeIQAbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 20:31:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:40174 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbeIQAbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 20:31:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2018 12:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,382,1531810800"; 
   d="scan'208";a="264007963"
Received: from vbsuresh-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.48.189])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2018 12:07:25 -0700
Date:   Sun, 16 Sep 2018 22:07:24 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alex Williamson <alex.williamson@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 02/17] compat_ioctl: move drivers to
 generic_compat_ioctl_ptrarg
Message-ID: <20180916190724.GA7473@linux.intel.com>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912150142.157913-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912150142.157913-2-arnd@arndb.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:01:03PM +0200, Arnd Bergmann wrote:
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 87a0ce47f201..a170f5ca7416 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -678,20 +678,10 @@ static long vtpmx_fops_ioctl(struct file *f, unsigned int ioctl,
>  	}
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vtpmx_fops_compat_ioctl(struct file *f, unsigned int ioctl,
> -					  unsigned long arg)
> -{
> -	return vtpmx_fops_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static const struct file_operations vtpmx_fops = {
>  	.owner = THIS_MODULE,
>  	.unlocked_ioctl = vtpmx_fops_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl = vtpmx_fops_compat_ioctl,
> -#endif
> +	.compat_ioctl = generic_compat_ioctl_ptrarg,
>  	.llseek = noop_llseek,
>  };

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
