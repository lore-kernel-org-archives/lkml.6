Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F03C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C8B20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="pEGqxwbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C8B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbeKJJ36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:29:58 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:59819 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeKJJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=Wxen9vpFc3gWyLTuaKUHU+hhlMQBHXjqsHdJtqPuXG0=; b=pEGqxwbSbVsV
        SAhzvtKcr6lZ0Lax/D4ndeV8eULjDKtCGa+YuJDHj9KtgplikLtkVqViO04lE0B3I472shbYBemiJ
        qDYs5M6DMiA+x3U/L/FuT65wbuEDcvPqFm7KLc3SOeUeyVIegqsfkkJWhy9bEunQ5E8nQGRUdhVHJ
        JkmLhckqRWKu++P39JdDFRnh2WY4hDHwmcWNeaXPed9it+PcGf4cOrpEIajKgsXBU0mF4wiQm4w7/
        cnpoZjGWEVvKPJ9VxQi1KPlEEMi8MYfQcbrH+xr57+LZt5MWoe5WeD4J8T5iCmhVZ2Kpydvfzu/LB
        novJ/y0Z7SbpwA605CPFHQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gLGUO-000F33-LS; Sat, 10 Nov 2018 00:47:01 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 4986BC0878;
        Sat, 10 Nov 2018 00:46:54 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] locking/lockdep: Support dynamic lockdep keys
Date:   Fri,  9 Nov 2018 15:46:43 -0800
Message-Id: <20181109234645.10530-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5uydkePdE6tEd1ZkVVMn7f1602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTaw6oIZeeoNM/b9+d3eFsdnRT3TfwJUHX8Iomn4FQQRkzZQ
 6OtBjX2dhf8r1xeX6dEPmOPCcmrlxrVn4hBIRExVAXDkcXwqI3EzqRI7b1h6dgZXghhvX/XYcNKh
 yStPYf2SMVD2aSIjidvu9uld8Cg6w3Na3a4Sq2B/kFzamfTzOvlh6JrwdFE3VeBUTJNYelfWmkxK
 lPIqRkL/7/6U08YytBraDGwEIZDNm3FFPB5oA2vDfspiyAfvT2vYZNeEBPdUU2xY9k05xUWOBvAE
 yzCo1e/+0B5vrWBnPRv/SRvh3u4aRbgWhlJGliIcU1pPShpiz0+zTHpR1MKAdfuxSMFUt9oEKDyI
 i2TYc0mwygqbDePFqNYxd2k3uDn/qKd1XmpnZkmoKaCddu+7NlVDxhSmLpdUVJCiJaHbRNV0B7+D
 dYalL4LoE8AgSzw+KJWjcRtcc9RSqsr+fEN3driEzVuElFPRl5S++pld5/UDMo7P5RhQbq/KReV9
 7XzSNMjDivEamUdylUIKhf3z2GAHxH7IF6gXEfReqZ4dmtoWME27WRcEtv0df4iZG0mKk/Ep5NSD
 tovSX6zw2EpyQc7ueRbTZRsH8lkyf9ZJErik0AEkWGjGGaKIM5Kur+HcJshveZg2du9og6pIKqjB
 b8rX+2tUERWeKKG4PAQYNyavp7c49DYhs0MbOrGYQ5Qip9sZcy4vmDJKzP9ZqdyTSOXhyhAMJqVq
 wZLxzdv0vmXAyD/Us2KTXNy9/5C4DwZhULU/9QJy2DNwOgV373pfDhBQ21Odylod286b/HcEs1jo
 BylROhA/ozOKY8ovm0zIkYHbY1YsAWLHjmIflW1HT8fSx6p650oTLts/mAi3bdTt+kCc0wdDXOcL
 ZzeHW3eH3XNZeK+JjY1tfOhAtvZx6Y0AdNK3cESf3l4QIqLeDGPNdpzYIliwlb5fkfM1e5HJHFb5
 Ll7KN3jU4u5J2BKajOBtQuHlEFIDTlUn65vf0opC4urL4Q==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

As you may know some false positive lockdep reports are the result of the
requirement to associate the same static lockdep key with all instances
of a locking object. Recently I encountered a lockdep false positive for
which I found no elegant way to suppress it other than by modifying the
lockdep implementation. Hence this series with two patches: one that
modifies lockdep and another patch that shows the false positive I and
others ran into and that also shows how to suppress that false positive.

Please keep in mind that I'm not a lockdep expert and hence that I'm not
sure whether the approach of patch 1/2 is correct.

Thanks,

Bart.

Bart Van Assche (2):
  locking/lockdep: Add support for dynamic depmaps and keys
  kernel/workqueue: Use dynamic lockdep keys for workqueues

 include/linux/lockdep.h   |  2 ++
 include/linux/workqueue.h | 28 ++++-------------------
 kernel/locking/lockdep.c  | 16 ++++++++++---
 kernel/workqueue.c        | 48 ++++++++++++++++++++++++++++++++-------
 4 files changed, 59 insertions(+), 35 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog

