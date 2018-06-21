Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB578C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625CA208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cS9mevEH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UbzuZ2Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625CA208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933417AbeFUNkT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:40:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57508 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932944AbeFUNkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:40:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9459C60B15; Thu, 21 Jun 2018 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529588416;
        bh=ewoDM6+ahfHGLVI/LYEtcO3kwRPcMLZgk79KVB64P8s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cS9mevEHHvNZO+pk1Q2enWoqu087kbeE5Qb34c+yzSeMVrNLwCRxfNusa5lZmR6A8
         ahdSTESXmz26KYM8eKPozRmqcVYx98FCU1EGoib4BV/CNBuwSFp1vjXNd2vljqRyUR
         gOgUXR9axI0Z7h8W1z2NCbiRVblQgc0oA0Y2jbNk=
Received: from [10.204.78.68] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83836604A6;
        Thu, 21 Jun 2018 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529588415;
        bh=ewoDM6+ahfHGLVI/LYEtcO3kwRPcMLZgk79KVB64P8s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UbzuZ2GlNcc8luEGz9C9yHprBudde09lNWlS4ZMdZfvLCdMyOzo65EVlnYhIBQ8Y9
         m32eo7BA+/tANe3bFmE7wqHw6MXUbLmOy/oXF/hq7CSPIHb0o0ANmlMuIlvC7YvELF
         LQ4AkQUDYKOG3ETi2GHfwOq3k9nVlB1twEtWzqCc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83836604A6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH 4.16 161/279] kthread, sched/wait: Fix kthread_parkme()
 completion issue
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180618080608.851973560@linuxfoundation.org>
 <20180618080615.492002239@linuxfoundation.org>
 <7ef9ee41-877b-0cc3-bd2d-f495b1d354bb@codeaurora.org>
 <20180620185138.GD32326@kroah.com>
From:   "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <37979107-e550-61b4-1e7a-d331584af9fa@codeaurora.org>
Date:   Thu, 21 Jun 2018 19:10:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620185138.GD32326@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Greg,

Yes more patches related to this are coming,
https://lkml.org/lkml/2018/6/7/317

So i thought, if all go together then it is good.

Regards
Gaurav

On 6/21/2018 12:21 AM, Greg Kroah-Hartman wrote:
> On Wed, Jun 20, 2018 at 12:10:31PM +0530, Kohli, Gaurav wrote:
>> Hi Greg,
>>
>> As more patches related to this are coming in 4.17, so it is better if all
>> go together on different branches, plz suggest.
> 
> I do not understand, sorry.  What is wrong with this as-is?  If I need
> to take other patches as well, please let me know what commits and what
> stable tree(s) they belong on.
> 
> thanks,
> 
> greg k-h
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
