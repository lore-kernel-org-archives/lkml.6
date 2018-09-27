Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9B6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0045C2172A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0045C2172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeI1Fdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:33:53 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15475 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeI1Fdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:33:53 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8RNCkRw033719;
        Fri, 28 Sep 2018 08:12:46 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Fri, 28 Sep 2018 08:12:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8RNCfYR033700
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 28 Sep 2018 08:12:46 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
To:     Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>, TongZhang <ztong@vt.edu>,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
 <20180926013329.GD31060@dastard> <20180926192426.472360ea@alans-desktop>
 <20180927013812.GF31060@dastard>
 <alpine.LRH.2.21.1809280720330.8410@namei.org>
 <20180927221948.GH31060@dastard>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <43032103-99c5-88ae-5aa1-a7906e059a8b@I-love.SAKURA.ne.jp>
Date:   Fri, 28 Sep 2018 08:12:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927221948.GH31060@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/28 7:19, Dave Chinner wrote:> IOWs, the security_file_ioctl() hook is almost completely useless in
> cases like this - you can't isolate the ioctl based on the file
> argument, because it can point to any file or directory in the
> filesystem. And without actually parsing, decoding and instantiating
> the the ioctl arguments, you can't tell the ioctl it can't act on
> specific targets. And because filehandle to dentry resolution
> results in disconnected dentries, the paths are not complete and
> hence path based security checks (e.g. tomoyo) are likely to be
> broken and unfixable...

Though TOMOYO uses pathname as a mandatory parameter, CaitSith
(currently waiting for review) does not.

CaitSith can filter filesystem specific ioctl() using fsmagic
and cmd parameter like:

10 acl ioctl path.fsmagic=0x9FA0
    audit 0
    10 deny cmd=@FORBIDDEN_IOCTLS_ON_PROCFS
    20 allow

CaitSith does ioctl() checks. Missing LSM check is a bug.
