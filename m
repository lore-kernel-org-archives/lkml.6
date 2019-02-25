Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FD2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B344F217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129844;
	bh=uVnLJcgyMe0peK9Ivx6BGEap0aoatFMeCz3d58fiCys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sOdpobvWTMPyP3LhQmYQnztCqr3tvActn/UMtt1NJjMx8gs/uySNbv4UoJRWYz2AB
	 64XrDAe57Eiifm74abUWX17x2n3qgK3QmjIrx9jZj1YDXqhD6C0ZtUXAZdbX7n9459
	 Y6o7e1ERaUUQpRTMu3lQrFWyKuuD/eA63p/V5iu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfBYVYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:24:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730793AbfBYVYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:24:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3743213A2;
        Mon, 25 Feb 2019 21:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129841;
        bh=uVnLJcgyMe0peK9Ivx6BGEap0aoatFMeCz3d58fiCys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmQ2xfihNwcmFlsVGTgUU9b9hYx+vXbZxz3KQzqsPKOJ9esysC7Y9fFYf8TofX432
         Ipivl8lP69SrxU2cZjgDPAji5DblSqPnFI98Pe3pQPswnh8gpbA/nfBFkFD8P4nSRH
         Bag//XGL0iOBOCyBO0loxBhAA8DqoLTn7j3wNzK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 084/152] bpf: dont assume build-id length is always 20 bytes
Date:   Mon, 25 Feb 2019 22:11:16 +0100
Message-Id: <20190225195048.842540274@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0b698005a9d11c0e91141ec11a2c4918a129f703 ]

Build-id length is not fixed to 20, it can be (`man ld` /--build-id):
  * 128-bit (uuid)
  * 160-bit (sha1)
  * any length specified in ld --build-id=0xhexstring

To fix the issue of missing BPF_STACK_BUILD_ID_VALID for shorter build-ids,
assume that build-id is somewhere in the range of 1 .. 20.
Set the remaining bytes to zero.

v2:
* don't introduce new "len = min(BPF_BUILD_ID_SIZE, nhdr->n_descsz)",
  we already know that nhdr->n_descsz <= BPF_BUILD_ID_SIZE if we enter
  this 'if' condition

Fixes: 615755a77b24 ("bpf: extend stackmap to save binary_build_id+offset instead of address")
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index e50ef5bca4213..98ad9dc3587aa 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -180,11 +180,14 @@ static inline int stack_map_parse_build_id(void *page_addr,
 
 		if (nhdr->n_type == BPF_BUILD_ID &&
 		    nhdr->n_namesz == sizeof("GNU") &&
-		    nhdr->n_descsz == BPF_BUILD_ID_SIZE) {
+		    nhdr->n_descsz > 0 &&
+		    nhdr->n_descsz <= BPF_BUILD_ID_SIZE) {
 			memcpy(build_id,
 			       note_start + note_offs +
 			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
-			       BPF_BUILD_ID_SIZE);
+			       nhdr->n_descsz);
+			memset(build_id + nhdr->n_descsz, 0,
+			       BPF_BUILD_ID_SIZE - nhdr->n_descsz);
 			return 0;
 		}
 		new_offs = note_offs + sizeof(Elf32_Nhdr) +
-- 
2.19.1



