Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87E8C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA1820835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA1820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeJCOo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:44:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:65068 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeJCOo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:44:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 00:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,335,1534834800"; 
   d="scan'208";a="88749359"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by orsmga003.jf.intel.com with ESMTP; 03 Oct 2018 00:56:41 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Wenwen Wang <wang6495@umn.edu>, Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] stm class: fix a missing-check bug
In-Reply-To: <1538542259-11868-1-git-send-email-wang6495@umn.edu>
References: <1538542259-11868-1-git-send-email-wang6495@umn.edu>
Date:   Wed, 03 Oct 2018 10:56:40 +0300
Message-ID: <87h8i379af.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wenwen Wang <wang6495@umn.edu> writes:

> In stm_char_policy_set_ioctl(), the 'size' field of the struct
> 'stp_polic_id' is firstly copied from the user space and then checked,
> because the length of the 'id' field in this struct, which represents an
> identification string, is not fixed. If the 'size' field cannot pass the
> check, an error code EINVAL will be returned. However, after the check, the
> whole struct is copied again from the user space. Given that the user data
> resides in the user space, a malicious user-space process can race to
> change the size between the two copies. By doing so, the attacker can
> bypass the check on the 'size' field and inject malicious data.

How? The id->size is not used for anything.

And even if there was a problem, this:

> -	if (copy_from_user(id, arg, size)) {
> +	if (copy_from_user(&id->master, (char __user *)arg + sizeof(size),
> +				size - sizeof(size))) {

is completely pointless.

>  		ret = -EFAULT;
>  		goto err_free;
>  	}
>  
> +	id->size = size;

So, if we did use id->size after the copying, we'd indeed have this line
in the code. But since we don't, it's also pointless, so it's not there.

Thanks,
--
Alex
