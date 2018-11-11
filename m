Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF68DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AC820818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xHEAxdyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AC820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbeKLJgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:36:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbeKLITF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:05 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF6B21508;
        Sun, 11 Nov 2018 22:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975349;
        bh=oR1LGesLeY46cJUrAhC2Hjj5E2UKOWnlqk9J3zu2nak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHEAxdyWxSHN+1iVVNqv/kjg8nPs2Y/ngF6q5I1osk+J0cxK2x5z3Lo9EKW27o1Vj
         R7tFUCjK3C4ESM7c9rtaFDVkHi2SB9eoGJfChVeYSwLXhAWG6ewt+WOaWLJaxRPV1x
         gqFw/5ez0PQYgR+K9LhcShuhlOK48laeKOFkjxcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Colascione <dancol@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Chenbo Feng <fengc@google.com>
Subject: [PATCH 4.19 360/361] bpf: wait for running BPF programs when updating map-in-map
Date:   Sun, 11 Nov 2018 14:21:47 -0800
Message-Id: <20181111221702.268411766@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Colascione <dancol@google.com>

commit 1ae80cf31938c8f77c37a29bbe29e7f1cd492be8 upstream.

The map-in-map frequently serves as a mechanism for atomic
snapshotting of state that a BPF program might record.  The current
implementation is dangerous to use in this way, however, since
userspace has no way of knowing when all programs that might have
retrieved the "old" value of the map may have completed.

This change ensures that map update operations on map-in-map map types
always wait for all references to the old map to drop before returning
to userspace.

Signed-off-by: Daniel Colascione <dancol@google.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Chenbo Feng <fengc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/syscall.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -741,6 +741,17 @@ err_put:
 	return err;
 }
 
+static void maybe_wait_bpf_programs(struct bpf_map *map)
+{
+	/* Wait for any running BPF programs to complete so that
+	 * userspace, when we return to it, knows that all programs
+	 * that could be running use the new map value.
+	 */
+	if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
+	    map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
+		synchronize_rcu();
+}
+
 #define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
 
 static int map_update_elem(union bpf_attr *attr)
@@ -831,6 +842,7 @@ static int map_update_elem(union bpf_att
 	}
 	__this_cpu_dec(bpf_prog_active);
 	preempt_enable();
+	maybe_wait_bpf_programs(map);
 out:
 free_value:
 	kfree(value);
@@ -883,6 +895,7 @@ static int map_delete_elem(union bpf_att
 	rcu_read_unlock();
 	__this_cpu_dec(bpf_prog_active);
 	preempt_enable();
+	maybe_wait_bpf_programs(map);
 out:
 	kfree(key);
 err_put:


