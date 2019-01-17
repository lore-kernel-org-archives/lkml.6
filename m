Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A39C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40D320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547722554;
	bh=0acxSCLOGjz+3b/XN+3IAD6MAO6yysV4z3rf/8U0dFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FTVx9I8tR9oDvIUXZrDIHWLMMpD1j05biRWMNRBdNGPtRGJM8OLoewqnI4FBbCGMR
	 WkrLb+cjOOb9C/LJUw+H1gszU63Z6Si2IG4GARXZUV/8dh26ENGiMszsZO8WuL2fsm
	 sSbhvaP8EMmyTe7qMYjeQU/r3qx25aA3hrcR6jAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfAQKzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:55:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfAQKzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:55:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E91D20657;
        Thu, 17 Jan 2019 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547722552;
        bh=0acxSCLOGjz+3b/XN+3IAD6MAO6yysV4z3rf/8U0dFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOYhzA3BQPrHWj4lVCjC2QQo1V+fzUqaFwH6O7Q+83p+sCS2CtJKQzPd/XYnai2fR
         yZmpB1hKx50dbBgQoITGoCSe0oUHxSxYUAuO/vX91Sy4m50q2wW4AGHpBp8xZ954ji
         aemKT2EXUkfJpQUlmH/4+Kt3PxXIJeAm/gpgHWI0=
Date:   Thu, 17 Jan 2019 11:55:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, shuah@kernel.org
Subject: Re: [PATCH v2] selftests: add binderfs selftests
Message-ID: <20190117105549.GA28882@kroah.com>
References: <20190117102821.10950-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117102821.10950-1-christian@brauner.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:28:21AM +0100, Christian Brauner wrote:
> This adds the promised selftest for binderfs. It will verify the following
> things:
> - binderfs mounting works
> - binder device allocation works
> - performing a binder ioctl() request through a binderfs device works
> - binder device removal works
> - binder-control removal fails
> - binderfs unmounting works
> 
> The tests are performed both privileged and unprivileged. The latter
> verifies that binderfs behaves correctly in user namespaces.
> 
> Cc: Todd Kjos <tkjos@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Now I am just nit-picking:

> +static void write_to_file(const char *filename, const void *buf, size_t count,
> +			  int allowed_errno)
> +{
> +	int fd, saved_errno;
> +	ssize_t ret;
> +
> +	fd = open(filename, O_WRONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		ksft_exit_fail_msg("%s - Failed to open file %s\n",
> +				   strerror(errno), filename);
> +
> +	ret = write_nointr(fd, buf, count);
> +	if (ret < 0) {
> +		if (allowed_errno && (errno == allowed_errno)) {
> +			close(fd);
> +			return;
> +		}
> +
> +		goto on_error;
> +	}
> +
> +	if ((size_t)ret != count)
> +		goto on_error;

if ret < count, you are supposed to try again with the remaining data,
right?  A write() implementation can just take one byte at a time.

Yes, for your example here that isn't going to happen as the kernel
should be handling a larger buffer than that, but note that if you use
this code elsewhere, it's not really correct because:

> +
> +	close(fd);
> +	return;
> +
> +on_error:
> +	saved_errno = errno;

If you do a short write, there is no error, so who knows what errno you
end up with here.

Anyway, just one other minor question that might be relevant:

> +	printf("Allocated new binder device with major %d, minor %d, and name %s\n",
> +	       device.major, device.minor, device.name);

Aren't tests supposed to print their output in some sort of normal
format?  I thought you were supposed to use ksft_print_msg() so that
tools can properly parse the output.


thanks,

greg k-h
