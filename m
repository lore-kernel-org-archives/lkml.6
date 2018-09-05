Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB35C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E9F206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="T3OKtxg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E9F206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeIEU5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:57:24 -0400
Received: from out002.mailprotect.be ([83.217.72.86]:59171 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeIEU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
        reply-to:sender:bcc; bh=qT+gab7npj0fuYK9GgShwzE+HTV+1EdIN8ilM5oy8cs=; b=T3OKt
        xg8Oo5Uuw7mgXLklNMmL2RR3FX86cwRotn5yhw9Cr9oCKJwOTUEl9sCDHkzdcWqzlL1ME4ixqljGy
        Kw8CQDfJmmkmVEH8kJuteMQfKdSulm5CcwYtyKNE3YdQ0mRwVuERwZvahPQf8eX54vvj3Lu8bQ6aq
        YJHbG+JEY37F86xzqV4bEgaSMULyyzWYVgF19vdHqrEVnPGc9csiWB1EqcSNdm+RdX0dECOabbPl1
        rDT1sfWQyCavL8NnbfGH/jT86geQYqeOV0/PGLrPzSIjbdlJ4av7kmFPhBUXJ2HsK/mFPp6zkuLBy
        aTwfty8wnnU7Jp6EWiFr5y722HLBg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1fxa2d-00055N-OS; Wed, 05 Sep 2018 17:48:28 +0200
Received: from dhcp-100-99-160-133.mtv.corp.google.com (unknown [104.132.0.69])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 8B37CC04F4;
        Wed,  5 Sep 2018 17:48:06 +0200 (CEST)
Message-ID: <1536162485.11534.3.camel@acm.org>
Subject: Re: [PATCH 0/3] Introduce a light-weight queue close feature
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk,
        ming.lei@redhat.com, bart.vanassche@wdc.com, sagi@grimberg.me,
        keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Date:   Wed, 05 Sep 2018 08:48:05 -0700
In-Reply-To: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.29)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5tOSyW01BN3DPoBYuKNPBKV602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO3rSb7sx03Eh5+sJdYLDGmxXlQ039JH/dFhkestwxgf01GiTQa0ZkwdhVkSPmKkWJXwD
 kmcakyAwJJV/QxOAbOcyHjmhAFHpAd4eKxCrReWqkpwAIYW4d4atrzQ2+eCb1vsxEvoEkX/hKeCE
 eHWc0mXbUclY7rRmqu8rL/UBdRXmz/exxsBWdqFE3ot3yjyqqDVhwj+gksJdo8D95rzzqXOlDoMI
 2nZpXoIN7+GeRys33jD2ThWfrUFXorRlAIeFOIpR6wdS52Y/DOhpm+/vY47CRPlNwQ4dZk+/yIr3
 L/mvTjAM/dumkra9cpsoz17Hk8ZB14E0iQtvqvjtp9rD8IdsUZvaSTd9AMKJoMQYDtGiCWL3lP/u
 PURcSS5CHqo0kSEAZTZL7Afi0gAil5AH2DYw+GkBfmCgZMyFgQPcMPX7iqxzhHUWe8d1H3CjBok2
 pTRS6qt3S+WlEa+gYibr4KH3Iz6Zvpm8cPQnANwkDQ5B7rC6qJUauybo1LLY1kzZaShHbcYINulb
 DyxluDB0JFsPBuLb2yeNi8Q3eJlwzLMkP3RM8BGHiURyfx72pZ/lQBgMoMLqMwiyXvPmgw+DKHHj
 BLgSt4z9qWdf+kVLYSLPzYNMG62m0sd6aksh73pyAxgjdBxUXi36UrG0xPHINbsSs+3PzZ8VZfdh
 209Pt+N03jkDR0BHY1ODOSRa5bPDq39j7hUMtXU2mVHogEgsZlxwRJ/eXhAiot4MY812nNgigqK/
 gT7mSN5j+WMj7ZiX1BOaHC5n55mAcO/V9SpUSv/jlorFXW3bhC79ikuI4jpG++DuIQUs/5JJj4C/
 n4CILj0aCto24hh56c4SeXFrhZPgasmQ+ypx8RqLYI2jraIHvRcvPAtzQ+e8CrSd7KejtqKkhN0R
 q3pS+QLjNwquHp4bcCTHsCYe2wmYCB7xseRF2+K26wUp40e8qDtSmR6ihfdjzQ6YC7Heg3Xf7O1T
 Od76fJ/Q31fN4cpMzIIZbTRlHTZz/5Oq0YkxJIMh4O7XvqCO25bqmF8LO6Ui9HwD0sslxpKr3ss1
 bZK3XAxcRnn2PAlbDjazCbhs7qBpykynMhJg3JCqbQadeU7yHdsAag7CGIMPiSNbC/ZkiVTdrjR/
 DqUACfX7+Vt4ujqmsj/5nFBrMyfpYuyanAZpMXssfrUnTS3hafrKhFJT6Xuzq9nsbqv0F9sDP+Bv
 kt03KheT4TV39MS5H4HvZszNarbzMxqbxy2yyESWY+VgzKgdDXRZRZtQP+zhQFSjlOSknLlw5L4e
 Cz/3YG7UsxcuYSVruWE=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-05 at 12:09 +-0800, Jianchao Wang wrote:
+AD4 As we know, queue freeze is used to stop new IO comming in and drain
+AD4 the request queue. And the draining queue here is necessary, because
+AD4 queue freeze kills the percpu-ref q+AF8-usage+AF8-counter and need to drain
+AD4 the q+AF8-usage+AF8-counter before switch it back to percpu mode. This could
+AD4 be a trouble when we just want to prevent new IO.
+AD4 
+AD4 In nvme-pci, nvme+AF8-dev+AF8-disable freezes queues to prevent new IO.
+AD4 nvme+AF8-reset+AF8-work will unfreeze and wait to drain the queues. However,
+AD4 if IO timeout at the moment, no body could do recovery as nvme+AF8-reset+AF8-work
+AD4 is waiting. We will encounter IO hang.
+AD4 
+AD4 So introduce a light-weight queue close feature in this patch set
+AD4 which could prevent new IO and needn't drain the queue.
+AD4 
+AD4 The 1st patch introduces a queue+AF8-gate into request queue and migrate
+AD4 preempt only from queue flags on it.
+AD4 
+AD4 The 2nd patch introduces queue close feature.
+AD4 
+AD4 The 3rd patch apply the queue close in nvme-pci to avoid the IO hang
+AD4 issue above.

Hello Jianchao,

Is this patch series based on a theoretical concern or rather on something
you ran into? In the latter case, can you explain which scenario makes it
likely on your setup to encounter an NVMe timeout?

Thanks,

Bart.

