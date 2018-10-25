Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AA6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509AB20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="FFk9of6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509AB20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeJYXkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:40:12 -0400
Received: from com-out001.mailprotect.be ([83.217.72.83]:34387 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJYXkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=7VwH29zaOPAYW4rcUsoeWId7ZanoT1ApXb5Hg8cIfZU=; b=FFk9of6ydhX3
        RdJYK7EVrRKJ+h87f0RGao8ZMURYzCMwTfv6+UKyYc/1118qivQ/UQwicSPFoCo3Q1bunaWnAhdDO
        Ri8EpCggjeHTWo4mWeqvQlmAmm3mT8fLXZETguvo8JZDyHt6DMVeFogAHlSZLePXEUPhHmBYErjyC
        5SPQrDt1lqjjQWbQ7RtvllOBXZpKdxQOqWzVNKmzQHG8EPGL6ViBZx0KAyOeph9vQ7iaetzHxy8E4
        QM78iSzK4ZUAprqSSnF5rvZGMcEJiMJjc872crGyokqDCY/rBeu217HSlX2yw4X/4zAb+JVPCrZAj
        sQAv2k0cJoHJB7ezZc0sOQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gFhDk-0005oa-Jg; Thu, 25 Oct 2018 17:06:49 +0200
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 0D9F0C13CF;
        Thu, 25 Oct 2018 17:06:30 +0200 (CEST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, tytso@mit.edu,
        bvanassche@acm.org
Subject: [PATCH 0/3] Suppress false positives triggered by workqueue lockdep annotations
Date:   Thu, 25 Oct 2018 08:05:37 -0700
Message-Id: <20181025150540.259281-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.07)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5loxt8C87gCVolMl1cyaPW9602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTZ8+YO8vChGFh3RuBr6W5W4OxXLKJYlhMSlvFrRpI1afX1e
 LdXSQEA2A8Mi+qZBNAJeQM+giwlWxLd3u9oewtfxHkDLQXsP0l4gM901I8VRelOcvqL7erI7cmyP
 F7rNKoQ6nIk9pDZAy5+Bh7H1WlayS5/54zeXko+dun95C2GNU5Zgdw/TrNerJc6iNElLjOSr+ury
 NtF5nL5Xd2xSs2A+BMmyNbDn7R5kilAhwr3KtFkEjgy2lIalT1bgV0G1B6wR6UEXs2CpqzV8tKL4
 SxeI7sn//RcLEIwmfxtejjVQPe75lAaleymDhM6q/bf6ylvMne8kEFi9whdly91uPt+NjZ/2BflP
 GJGaubsXCX08RTS5uosuJIDwx+20ECcNkg/IQ6hdCufMS9/BCap8vQGHPoGLQmyHoPQ6TB1wLqq5
 Qkv8gSmPI3hcWIP6I/UqgklFXXqpVcVFhDpgnnGd9TvwpduFUH54xozIXYC/AO4ruQQZSCdFgRT7
 uB3pznGUiPdhD/iWD0V++qD0gbQQTy2MSHRP7JsY9SIFlGCnk976CRbAiblZVZAoQGrzL+lZC3bY
 5Qx4fJOk03R5fJtf/Dv/gSdxjDi1ltP+wptveb2Ijci0u19DQjpIcLYmJ1eNF7Hj7YQfAz1XFm6U
 HzM/nSXDBRiEpFawT+XpBprqjhqmHpw7a3o4X/1BhEnPIxiTqXl3MEaSi/a2UpaZXx577r2VX5L+
 J71s/JQPh4CpIirAWU4JGuUMSPEM4jSvu0DxlABITZexxilFc9uhI53Z4n/X50oTLts/mAi3bdTt
 +kCc014dWJl0kwfXlmvU2bsvJrs2z0B+fREYIUiwb9iVHkqzKJAkzzNYrfNt4PYN+BpSTJ6QZDvV
 AcJRgqDug2GSJBdRZgzstIAg6rIwnyMY+7rV9R/2gMGq0KWAzmMf+ibVDvxqiYOBPyjSuNX12Foj
 Ct6b+3PptLpbDCN56+pk/nrDlJMRPkiuApKqkLmPwA7QezIzJvw9qxD5zQLggp7fQfdZbzftsOiK
 1rBamiUlczHh9dLX6qBpW3U5Ey2lggFy2qdXG55oeqRZoYKir3ci7UmvMyduSR5H9stXx9/Mf6KV
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

In my tests with kernel v4.19 I noticed that several new false positive
reports were generated by the workqueue lockdep annotations. This patch
series addresses one of these false positives. Another false positive
will be addressed by a patch for the NVMe target driver. Please consider
these patches for the upstream kernel.

Thanks,

Bart.

Bart Van Assche (3):
  kernel/workqueue: Remove lockdep annotation from __flush_work()
  kernel/workqueue: Surround work execution with shared lock annotations
  kernel/workqueue: Suppress a false positive lockdep complaint

 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog

