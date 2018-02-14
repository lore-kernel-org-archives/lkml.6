Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225fA/omrNoLX/XmNGEuvrbvOb6Tv0bLJjY9rM/+XxBOCbefddVEHNu/Tef80Vf9rWZhU3H0
ARC-Seal: i=1; a=rsa-sha256; t=1518578907; cv=none;
        d=google.com; s=arc-20160816;
        b=bmb/M4rJyRE8xQN/R3rIpYyUJW+S8dwXYlHs5aipZ2Vbic8JLNIqfwDJSEfN8W9oF1
         s2fQId120Ly9ItiwWoit0xO21bg7cgpu6z7Q7tIrxkEQmqaQQL3Nk4+D5r4nokY3LvcN
         zz8xGwL8yTUFaTFn3J/uEg7cctwM5Qdp1WAgE/zSKBqK2BHl5LgnsBmPHt4eiFurPgyi
         zEoXYVa6NskgrJnHkcdUO0/EmYpBx7hBTT37++JnkDaSsf5JpWDV8aFZuavhsS8ahAsJ
         hzK36GYKluGpD77kZMx/+2WT9UFbO6suzwguTdDLOVIvS3S+qg1t6L7Xbkplco/Tbagm
         Zd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=+6jIy5uZrI15UR7JPJiDTCFgVHNQAtNIa0R5yN1IkWk=;
        b=tS7H5rIM2IkGyDDSkiAud94BQxt99Bt7DQUXiCT63TkMQvaxFh9QAbyeMEykU6NPho
         1RWGOKvRdb3eD2DcvorgOFTyHaTe+jyt7pwMDMhfBoDHHqpGFxY2jhb6VcJprrmTeR4j
         tnCnpsthSQRw6gqlbN/Iv8cvUGcY0N3m4BpRBuIhH5sq1guvMWfsoodHLM6YKNukn4MN
         0HGQde7cAbtevNBi5d3nIsjF7eAdbt81istJiWlj5UJTxO2dSfDWz3awqtofbqceXQpG
         adFW7FmK3L9Hmwi+GQ8RasXdAdKoTy7PMlO0YIjtb0L7NMYPedKTKLZAKhmqnQ51YdM4
         824A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=aRqXgS9o;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=aRqXgS9o;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966717AbeBND20 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Feb 2018 22:28:26 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45515 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966713AbeBND2Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Feb 2018 22:28:25 -0500
Date: Tue, 13 Feb 2018 19:28:22 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Li Zhijian <zhijianx.li@intel.com>,
        Philip Li <philip.li@intel.com>
Subject: Re: [PATCH] selftests/bpf/test_maps: exit child process without
 error in ENOMEM case
Message-ID: <20180214032820.jjedkz2z4bii4asz@ast-mbp.dhcp.thefacebook.com>
References: <1518443524-18373-1-git-send-email-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518443524-18373-1-git-send-email-lizhijian@cn.fujitsu.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592203458729605542?=
X-GMAIL-MSGID: =?utf-8?q?1592345396545526039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 09:52:04PM +0800, Li Zhijian wrote:
> From: Li Zhijian <zhijianx.li@intel.com>
> 
> test_maps contains a series of stress tests, and previously it will break the
> reset tests when it failed to alloc memory.
> -----------------------
> Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
> Failed to create hashmap key=16 value=262144 'Cannot allocate memory'
> Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
> Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
> test_maps: test_maps.c:955: run_parallel: Assertion `status == 0' failed.
> Aborted
> not ok 1..3 selftests:  test_maps [FAIL]
> -----------------------
> after this patch, the rest tests will be continue when it occurs a ENOMEM failure
> 
> CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> CC: Philip Li <philip.li@intel.com>
> Suggest-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Li Zhijian <zhijianx.li@intel.com>

could you please resend it and cc netdev so it appears in patchworks properly.

Thanks!

