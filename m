Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366DAC07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5CF20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLAbJhuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5CF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeLHAxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:53:30 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35301 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLHAxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:53:30 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so9877000itp.0;
        Fri, 07 Dec 2018 16:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEbODVp2HpGjxgjKeclkzSSi6q3c0+//7NxFbJhw2io=;
        b=nLAbJhuhGRi7YZuM8dIgd1fubmTb5jwEymEd94oAYmsh+hUQNce1hBhrUr82VxjXho
         xWWbKxNgF/f/QjsBR4voASQlygcxg/lnxQkURe3DlpEYzDWEW2TuleHi+cR1xRCuI1jA
         ZmWaGkVmJorKuzsw7WuRbw/W27Eq/rbX+vFXIqXYcbu42qxU325rN8apVkE3B1v1hvos
         1+uoVaaUGwBgL1zjeS/2pQNoCBgoLU8oXCNSpvD/j32er6v7GMcC6Bq/XmyvgzF24U/o
         nEO2BSO/HNMorGdgcuk5HoTIVIYd9+sXCkYj2GkHG8i2hGFrOE7b4/BQiWcURoL05dyW
         wKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEbODVp2HpGjxgjKeclkzSSi6q3c0+//7NxFbJhw2io=;
        b=HP7raWIDhH3xiP9USMkEwvG7JaTv+6NtorXVnd5r9bIWWN/p3sJ+A4F8fhnOit18MC
         cK1H5+GLFL3g+9dDuKgVB/q4AS+akqP3g6NIsKvO1qj5CDOffQeE7FNbJE/r/S5aXFqh
         Uny3q64aXgkHR4aNDh+NmYz1pDJPGocPIuAtcBMFHT32Dl6Ke4rqOXFsMGTzUUpeLDs7
         awA62f87dFdChmFDpeFDDUNTD0BGjOb9hehdicJAY0j2OGJtXCbtyAFrOy2fQY1iHfCR
         7kdtg0l5wcHnwNpQM89NVbYSgEOeAaf126/MenlDQ7iagPD9CezXmPqGoJVPACd3Arp1
         +G0A==
X-Gm-Message-State: AA+aEWbMikt80hvUwj70pCs6KhwDmSpenfJ8WCo/Wp2eZGGULfXvgg94
        QGAOPEuYi++6xVh/IEaX8sqdevZNHZE=
X-Google-Smtp-Source: AFSGD/XDowsqvhY2gKYCkm2DNkTi6yItlvJK8GyJlGfbHa6f/jcYUBjy66XpZeil9WhUProZZmdqgA==
X-Received: by 2002:a05:660c:88b:: with SMTP id o11mr3824996itk.9.1544230408762;
        Fri, 07 Dec 2018 16:53:28 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::6:9a2e])
        by smtp.gmail.com with ESMTPSA id 21sm2069769iou.79.2018.12.07.16.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 16:53:28 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     netdev@vger.kernel.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 1/3] bpf: pass struct btf pointer to the map_check_btf() callback
Date:   Fri,  7 Dec 2018 16:53:13 -0800
Message-Id: <20181208005315.3500-1-guro@fb.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If key_type or value_type are of non-trivial data types
(e.g. structure or typedef), it's not possible to check them without
the additional information, which can't be obtained without a pointer
to the btf structure.

So, let's pass btf pointer to the map_check_btf() callbacks.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h   | 3 +++
 kernel/bpf/arraymap.c | 1 +
 kernel/bpf/lpm_trie.c | 1 +
 kernel/bpf/syscall.c  | 3 ++-
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e82b7039fc66..128d93540b23 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,6 +23,7 @@ struct bpf_prog;
 struct bpf_map;
 struct sock;
 struct seq_file;
+struct btf;
 struct btf_type;
 
 /* map is generic key/value storage optionally accesible by eBPF programs */
@@ -52,6 +53,7 @@ struct bpf_map_ops {
 	void (*map_seq_show_elem)(struct bpf_map *map, void *key,
 				  struct seq_file *m);
 	int (*map_check_btf)(const struct bpf_map *map,
+			     const struct btf *btf,
 			     const struct btf_type *key_type,
 			     const struct btf_type *value_type);
 };
@@ -126,6 +128,7 @@ static inline bool bpf_map_support_seq_show(const struct bpf_map *map)
 }
 
 int map_check_no_btf(const struct bpf_map *map,
+		     const struct btf *btf,
 		     const struct btf_type *key_type,
 		     const struct btf_type *value_type);
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 24583da9ffd1..25632a75d630 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -382,6 +382,7 @@ static void percpu_array_map_seq_show_elem(struct bpf_map *map, void *key,
 }
 
 static int array_map_check_btf(const struct bpf_map *map,
+			       const struct btf *btf,
 			       const struct btf_type *key_type,
 			       const struct btf_type *value_type)
 {
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index bfd4882e1106..abf1002080df 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -728,6 +728,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 }
 
 static int trie_check_btf(const struct bpf_map *map,
+			  const struct btf *btf,
 			  const struct btf_type *key_type,
 			  const struct btf_type *value_type)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index aa05aa38f4a8..7c2e8ab03a34 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -456,6 +456,7 @@ static int bpf_obj_name_cpy(char *dst, const char *src)
 }
 
 int map_check_no_btf(const struct bpf_map *map,
+		     const struct btf *btf,
 		     const struct btf_type *key_type,
 		     const struct btf_type *value_type)
 {
@@ -478,7 +479,7 @@ static int map_check_btf(const struct bpf_map *map, const struct btf *btf,
 		return -EINVAL;
 
 	if (map->ops->map_check_btf)
-		ret = map->ops->map_check_btf(map, key_type, value_type);
+		ret = map->ops->map_check_btf(map, btf, key_type, value_type);
 
 	return ret;
 }
-- 
2.19.2

