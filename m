Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F2BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97212172D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97212172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeHUIcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 04:32:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51172 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHUIcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 04:32:15 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E0023BC8;
        Tue, 21 Aug 2018 05:13:40 +0000 (UTC)
Date:   Tue, 21 Aug 2018 07:13:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] staging: android: ion: check for kref overflow
Message-ID: <20180821051336.GA23394@kroah.com>
References: <20180821013057.139644-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821013057.139644-1-drosen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 06:30:57PM -0700, Daniel Rosenberg wrote:
> Userspace can cause the kref to handles to increment
> arbitrarily high. Ensure it does not overflow.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
> 
> This patch is against 4.4. It does not apply to master due to a large
> rework of ion in 4.12 which removed the affected functions altogther.
> It applies from 3.18 to 4.11, although with a trivial conflict resolution
> for the later branches.
> 4c23cbff073f3b9b ("staging: android: ion: Remove import interface")
> 
>  drivers/staging/android/ion/ion.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 374f840f31a48..11f93a6314fdb 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -15,6 +15,7 @@
>   *
>   */
>  
> +#include <linux/atomic.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/file.h>
> @@ -387,6 +388,15 @@ static void ion_handle_get(struct ion_handle *handle)
>  	kref_get(&handle->ref);
>  }
>  
> +/* Must hold the client lock */
> +static struct ion_handle *ion_handle_get_check_overflow(
> +					struct ion_handle *handle)
> +{
> +	if (atomic_read(&handle->ref.refcount) + 1 == 0)
> +		return ERR_PTR(-EOVERFLOW);
> +	ion_handle_get(handle);
> +	return handle;
> +}
> +
>  static int ion_handle_put_nolock(struct ion_handle *handle)
>  {
>  	int ret;

I tried to apply this patch, but it looks like you hand-edited it which
made it impossible to apply.  Did you do that, or did git really create
this broken diff exactly as-is?

Try applying this patch yourself, you will see the error.  I could fix
it by manually editing the diff metadata but I really shouldn't have to
as that implies you did not test the patch you sent me :(

thanks,

greg k-h
