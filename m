Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0EFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210222077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="uaikIQf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210222077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeIEU2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:28:41 -0400
Received: from com-out001.mailprotect.be ([83.217.72.83]:58513 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeIEU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:28:41 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2018 16:28:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
        reply-to:sender:bcc; bh=jKFToSCL5M1121VwnDBozoERzIDamHpeEQpDaQw14pg=; b=uaikI
        Qf9Ky5AKBvriBlj2cZ2hQXTrKjEEnQeoKe1spWboS1yK/1X6zLAk1OcP0LrQCRzs+1JhIIWuP5UPM
        4rvoEG6nfULPn5t3c9mau0HQY5ttuoEXmVwI2qakp1x9StK4aQ8XSW8J8bBhso5kXTjn6BFFpU1QT
        N57HU1SEng22+CtsLZiMpeaiIS5MjMTItNhqwEDJlmpRKqYclhlwKjEAGOqGMSfSzadNWtHrHRUdJ
        X9eOk5AaY1HgkndVQ39gv5TVr5lptqYhyV2qWZn63yM9UhEe+XXIF27RJEvHHAm/SiY0jAH8vW6Ya
        Cjn8TOO3fgKCGblar/oK4olLac7qw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1fxaBI-000DLL-Hx; Wed, 05 Sep 2018 17:57:30 +0200
Received: from dhcp-100-99-160-133.mtv.corp.google.com (unknown [104.132.0.69])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id E1CA5C0D57;
        Wed,  5 Sep 2018 17:57:17 +0200 (CEST)
Message-ID: <1536163037.11534.6.camel@acm.org>
Subject: Re: [PATCH 2/3] blk-core: introduce queue close feature
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk,
        ming.lei@redhat.com, bart.vanassche@wdc.com, sagi@grimberg.me,
        keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Date:   Wed, 05 Sep 2018 08:57:17 -0700
In-Reply-To: <1536120586-3378-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
         <1536120586-3378-3-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.22)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5vygouLKtfugZlg16fLS/p9602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO3rSb7sx03Eh5+sJdYLDGmxXlQ039JH/dFhkestwxgf01GiTQa0ZkwdhVkSPmKkWJXwD
 kmcakyAwJJV/QxOAbOcyHjmhAFHpAd4eKxCrReWqkpwAIYW4d4atrzQ2+eCb1vsxEvoEkX/hKeCE
 eHWc0mXbUclY7rRmqu8rL/UBdRXmz/exxsBWdqFE3ot3yjyqqDVhwj+gksJdo8D95rzzqXOlDoMI
 2nZpXoIN7+GeRys33jD2ThWfrUFXorRlAIeFOIpR6wdS52Y/DOhpm+/vY47CRPlNwQ4dZk+/yIr3
 L/mvTjAM/dumkra9cpsoz17Hk8ZB14E0iQtvqvjtp9rD8IdsUZvaSTd9AMKJoMQYDtGiCWL3lP/u
 PURcSS5CHqo0kSEAZTZL7Afi0gAil5AH2DYoUDDC0njhC0d9pLy5bk6KiqxzhHUWe8d1H3CjBok2
 pTRS6qt3S+WlEa+gYibr4KGwFVccsCAZ2dyI5DARqfkZ7rC6qJUauybo1LLY1kzZaShHbcYINulb
 DyxluDB0JFsPBuLb2yeNi8Q3eJlwzLMkP3RM8BGHiURyfx72pZ/lQBgMoMLqMwiyXvPmgw+DKHHj
 BLgSt4z9qWdf+kVLYSLPzYNMG62m0sd6aksh73pyAxgjdBxUXi36UrG0xPHINbsSs+3PzZ8VZfdh
 209Pt+N03jkDR0BHY1ODOSRa5bPDq39j7hUMtXU2mVHogEgsZlxwRJ/eXhAiot4MY812nNgigqK/
 gT7mSN5j+WMj7ZiX1BOaHC5n55mAcO/V9SpUSv/jlorFXW3bhC79ikuI4jpG++DuIQUs/5JJj4C/
 n4CILj0aCto24hh56c4SeXFrhZPtfiQm+nt+VSQWe8IWQJI3JtFZSvjumd171+CiP47OO6KkhN0R
 q3pS+QLjNwquHp4bcCTHsCYe2wmYCB7xseRF2+K26wUp40e8qDtSmR6ihfdjzQ6YC7Heg3Xf7O1T
 Od76fJ/Q31fN4cpMzIIZbTRlHTZz/5Oq0YkxJIMh4O7XvqCO25bqmF8LO6Ui9HwD0svkd1cry9mG
 eszCMQ2iS6FqPAlbDjazCbhs7qBpykynMhJg3JCqbQadeU7yHdsAag6hDnwpq670aoEqrPmvfiYM
 DqUACfX7+Vt4ujqmsj/5nFBrMyfpYuyanAZpMXssfrUnTS3hafrKhFJT6Xuzq9nsbqv0F9sDP+Bv
 kt03KheT4TV39MS5H4HvZszNarbzMxqbxy2yyESWY+VgzKgdDXRZRZtQP+zhQFSjlOSknLlw5L4e
 Cz/3YG7UsxcuYSVruWE=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-05 at 12:09 +-0800, Jianchao Wang wrote:
+AD4 blk queue freeze is often used to prevent new IO from entering
+AD4 request queue. However, becuase we kill the percpu-ref
+AD4 q+AF8-usage+AF8-counter when freeze queue, we have to drain the request
+AD4 queue when unfreeze. This is unnecessary for just preventing new
+AD4 IO. In addition, If there is IO timeout or other issue when unfreeze
+AD4 the queue, the scenario could be very tricky.
+AD4 
+AD4 So we introduce BLK+AF8-QUEUE+AF8-GATE+AF8-CLOSED to implement a light-weight
+AD4 queue close feature base on the queue+AF8-gate to prevent new IO from
+AD4 comming in queue which will not need to drain the queue any more.

Does the +ACI-queue gate close+ACI feature cause blk+AF8-get+AF8-request() /
blk+AF8-mq+AF8-get+AF8-request() to block until blk+AF8-clear+AF8-queue+AF8-closed() is called? If
so, I think we need a better name for this feature. How about calling these
two operations suspend and resume?

Thanks,

Bart.
