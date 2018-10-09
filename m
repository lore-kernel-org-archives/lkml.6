Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C289BC43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753BE2150F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753BE2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeJJFr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:47:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37631 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJFr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:47:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so1511492pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 15:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XC6Oa3GFkiQoaiWxH264KZ7TuRSuwM2VWb/wf0LE0v4=;
        b=Kra5/UOtZF5+1DUbXRjjLAexsgDcp+/IkQlk/p8mH7Du51hCQDYJbgixEbwJRK5URu
         qg+UXvveeUs5RSRUUyXmZw4pjTvav2w2V6n6ifDphW7FYGzctqw1gH10onn3n7gwjuG+
         0/ExprQE9xZFlKI7iNQVG9H4aSYln1mlxbrpCL+KjrJihzKsZPRY6ve5wHCE8aUoyodr
         m+jHWQTa5u5TuFA5qxpqYzMI6cFKnegzXj690oLGGuc2RPrqIvTYGygtrSah3cYda+aD
         PUBAhziFdP9h38vyWUqyygo25TuSJ4lfXsMypNrDrOTTK9mnFONN5Zdc//iAkFN4TPmn
         ZTDQ==
X-Gm-Message-State: ABuFfoi2wRIIsv8PoALrmEcvGI5CLLiRAmB6UNdIodjfEIlZ/2i1IClW
        PVI/nbxZWbHkIGWLV8OMwkR/S40w
X-Google-Smtp-Source: ACcGV60cE5Dz6YLovIC8QrLq1XkZuEUN204lEeHJHLOzPQM7WmBb/GcU+Vdi+j2zHiF1qZS5ahaLDA==
X-Received: by 2002:a62:6dc3:: with SMTP id i186-v6mr21796881pfc.218.1539124098996;
        Tue, 09 Oct 2018 15:28:18 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::7:ebaa])
        by smtp.gmail.com with ESMTPSA id a64-v6sm29743884pfe.32.2018.10.09.15.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 15:28:18 -0700 (PDT)
Date:   Tue, 9 Oct 2018 15:28:15 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu fixes for-4.19-rc8
Message-ID: <20181009222815.GA56709@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

The new percpu allocator introduced in 4.14 had a missing free for the
percpu metadata. This caused a memory leak when percpu memory is being
churned resulting in the allocation and deallocation of percpu memory
chunks.

Thanks,
Dennis

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-4.19-fixes

for you to fetch changes up to 6685b357363bfe295e3ae73665014db4aed62c58:

  percpu: stop leaking bitmap metadata blocks (2018-10-07 14:50:12 -0700)

----------------------------------------------------------------
Mike Rapoport (1):
      percpu: stop leaking bitmap metadata blocks

 mm/percpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index a749d4d96e3e..4b90682623e9 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1212,6 +1212,7 @@ static void pcpu_free_chunk(struct pcpu_chunk *chunk)
 {
 	if (!chunk)
 		return;
+	pcpu_mem_free(chunk->md_blocks);
 	pcpu_mem_free(chunk->bound_map);
 	pcpu_mem_free(chunk->alloc_map);
 	pcpu_mem_free(chunk);
