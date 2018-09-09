Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087BCC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AF320833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="qVL1xQhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AF320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeIIXhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 19:37:24 -0400
Received: from out002.mailprotect.be ([83.217.72.86]:37755 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeIIXhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 19:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
        reply-to:sender:bcc; bh=F8rcYY2BgW5XjVcGPBlfEOfhdK3w/Ff9i9E689JTTSY=; b=qVL1x
        QhYqyHfaNIgagKOMDWU+CeII5LO7AXJzJDkYsNCj3IPs/8i35snCZRAMNnbc/keaQK6L2w5mvgX+T
        NB4Dw/A/u4ZicpxA6PsEVzt0fOpdblFcsv+vPp8zQjqtrmjN6E8m+LTFrPpICAxrMZvile4YRZMWI
        ujp/CggpsOREsc+EQwZChWlke5gLeP7WIcmk142HRpJyGOKDil/PcatD8OMUAp1ydZAo3/8HY/jue
        o4fHEMWesq1rBw8iXcJUryweCJld4HDF9eVPHzXYDNxHshn+NQDUC4FUc73zWs/FVdUqunzN44ycx
        B5KE+y3bmWzHOfsdA8yu7ManVHyag==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1fz4jG-0007aU-Au; Sun, 09 Sep 2018 20:46:40 +0200
Received: from [172.31.183.39] (unknown [216.9.110.9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id CA94CC04F3;
        Sun,  9 Sep 2018 20:46:21 +0200 (CEST)
Message-ID: <1536518780.23536.3.camel@acm.org>
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Date:   Sun, 09 Sep 2018 11:46:20 -0700
In-Reply-To: <20180909125824.9150-1-ming.lei@redhat.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.17)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5isWAYY6h+X1ehEEPhcpgQ9602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO74yoiKRT4T5Dx7UFe3A/4vx+tGGpUzQMWnTzvwoJh8inA556vZ0tToLKVtzEJyernr6
 lJ2gtQvpbG5RwzJtlYC0+LDF4/mgPok67WzA4VUoGcQgIyVpUkklS+w+r6IjQxPtVuiEKD4DHz1b
 jNS4/Cd0DckQp81EoIRVnif+ZCSpvIj6Hj+XWRCbm1ZihxwB/h2mlP2W9u+agdcanH6cUDPhtIdB
 kUNQyNMiiqabnglhOQsJyuwIuKKE6hUQVDmtslY+5adZvWXoGLcQcb78EuiDwIE7VKe+bqpcdCns
 72R1ryXV/dtSUBUsNX+GjGv3uCPv7DM1px3tFZ2pzU0W1muu1WaiZswnh7amfkLTIEwd6LkGFt94
 dBx3TpAokA4UmQMOISbgvXoYMWePmBZprYvXZ390tTXDb91Nnaf1Gz774hJ877w3BrOappvVwxNq
 XRAuP34BOWH1phOxN2OsfVydlSfkuEofPX38FHNGtteJIxfs2qKc0fhF4YMd0lwHwOXyY7DGIntS
 iB4r6Kj1fsjhU4uNidRvIqET+QqZJq4ZpAEntM8yKElR+Y84QVlpY2IxD5NlKb4tGrqqw6Lkew2L
 4UiXG51/x0Ki/1/azQiQnOohEibyptTVfIJK/lrvEnFQ14pzlcriKSE0Pc9zNwx/Pvs8ClM0a45+
 4VPUlD0CnUW8tYWq4wnhhPHT8+TQh8rH3Rie1oymikOSE+dPfld27mNv8zfXr6pjGFGxTl7OsHmo
 +uYudJKJ8bi5x3tbpQbP+6IG9hKGwQE2ZCOASu8t9hKEpwdCkOgd8bfFD/SKKSyOAyj52etf543G
 ART2oFC/LbdJldJ8xntHMcYfWXY1sk5R8lEZMP55FHsb8E+AxrIue+lvCJq+EC3X2lZMnYjKFojr
 vUjjKLsywQkk4erakuufO4hikN4s2SKN+ix4hCRcsl1Yv6JBifdoyMw3RSUKRK6Obnxr/EH5cLWQ
 Jzq2BmRxGQKegzOmzXDxmXJac+rTn2RKSj7oL0gdYd3CQvJF3Ig4XxZf+IRR6I0SNCBnIKDFkcg0
 DoDn7tP2jpvLzooP2u7NmT+kk2Aa2HBjKXPmS1QpMIP6MUA7s7Komme/1kOJWei7OBR2bABRMlG5
 MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-09 at 20:58 +-0800, Ming Lei wrote:
+AD4 Now percpu+AF8-ref+AF8-reinit() can only be done on one percpu refcounter
+AD4 when it drops zero. And the limit shouldn't be so strict, and it
+AD4 is quite straightforward that percpu+AF8-ref+AF8-reinit() can be done when
+AD4 this counter is at atomic mode.
+AD4 
+AD4 This patch relaxes the limit, so we may avoid extra change+AFs-1+AF0 for NVMe
+AD4 timeout's requirement.
+AD4 
+AD4 +AFs-1+AF0 https://marc.info/?l+AD0-linux-kernel+ACY-m+AD0-153612052611020+ACY-w+AD0-2

Is the NVMe driver the only block driver that hangs if it is attempted to
freeze its request queue when a request times out? If so, can this hang be
fixed by modifying the NVMe driver instead of by modifying the percpu
refcount implementation?

Thanks,

Bart.

