Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C262C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A368A2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A368A2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbeGZTpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:45:55 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:49674 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730095AbeGZTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:45:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8D59B1807F308;
        Thu, 26 Jul 2018 18:27:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mask95_61ba8c5090b07
X-Filterd-Recvd-Size: 6204
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Jul 2018 18:27:51 +0000 (UTC)
Message-ID: <1236369d28b2f1f5389ff652c4eb89e699e6481e.camel@perches.com>
Subject: [RFC PATCH] checkpatch: check for function calls with struct or
 union on stack
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 26 Jul 2018 11:27:50 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was cc'd on a patch where structs were used on stack instead
of using pointers to the structs.  This can cause defects when
the calling function modifies the stack struct instead of the
calling function's struct.

Possible patch below, but it may be overkill for the number of
instances
where this is actually an issue.

Thoughts?

There are what seems to be some false positives for a few of the
.h files in include/linux/... where the false positives are for
very small structs where the indirection via a pointer might be
slower than than the stack use.

For instance: (some duplicates removed)

$ git ls-files -- "include/linux/*.h" | \
  while read file ; do  ./scripts/checkpatch.pl -f --types=aggregate_on_stack $file --no-summary --quiet; done
WARNING: Unusual use of 'struct bvec_iter' on stack
#520: FILE: include/linux/bio.h:520:
+void zero_fill_bio_iter(struct bio *bio, struct bvec_iter iter);

WARNING: Unusual use of 'struct fd' on stack
#433: FILE: include/linux/bpf.h:433:
+struct bpf_map *__bpf_map_get(struct fd f);

WARNING: Unusual use of 'struct ceph_vino' on stack
#465: FILE: include/linux/ceph/osd_client.h:465:
+extern struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *,
+				      struct ceph_file_layout *layout,
+				      struct ceph_vino vino,
+				      u64 offset, u64 *len,
+				      unsigned int which, int num_ops,
+				      int opcode, int flags,
+				      struct ceph_snap_context *snapc,
+				      u32 truncate_seq, u64 truncate_size,
+				      bool use_mempool);
[]
WARNING: Unusual use of 'union extcon_property_value' on stack
#63: FILE: include/linux/extcon-provider.h:63:
+extern int extcon_set_property(struct extcon_dev *edev, unsigned int id,
+				unsigned int prop,
+				union extcon_property_value prop_val);
[]
WARNING: Unusual use of 'struct ppa_addr' on stack
#528: FILE: include/linux/lightnvm.h:528:
+extern int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev,
+			      struct nvm_chk_meta *meta, struct ppa_addr ppa,
+			      int nchks);
[]
WARNING: Unusual use of 'struct pin_cookie' on stack
#367: FILE: include/linux/lockdep.h:367:
+extern void lock_repin_lock(struct lockdep_map *lock, struct pin_cookie);
[]
WARNING: Unusual use of 'struct kqid' on stack
#77: FILE: include/linux/quota.h:77:
+extern bool qid_eq(struct kqid left, struct kqid right);
[]
WARNING: Unusual use of 'struct reg_field' on stack
#1051: FILE: include/linux/regmap.h:1051:
+struct regmap_field *devm_regmap_field_alloc(struct device *dev,
+		struct regmap *regmap, struct reg_field reg_field);

WARNING: Unusual use of 'struct rpmsg_channel_info' on stack
#121: FILE: include/linux/rpmsg.h:121:
+struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *,
+					rpmsg_rx_cb_t cb, void *priv,
+					struct rpmsg_channel_info chinfo);

WARNING: Unusual use of 'struct rtc_time' on stack
#26: FILE: include/linux/rtc.h:26:
+ktime_t rtc_tm_to_ktime(struct rtc_time tm);

WARNING: Unusual use of 'struct timespec64' on stack
#193: FILE: include/linux/rtc.h:193:
+extern int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec);
[]
WARNING: Unusual use of 'struct tnum' on stack
#25: FILE: include/linux/tnum.h:25:
+struct tnum tnum_lshift(struct tnum a, u8 shift);
[]
WARNING: Unusual use of 'struct vring' on stack
#81: FILE: include/linux/virtio_ring.h:81:
+struct virtqueue *__vring_new_virtqueue(unsigned int index,
+					struct vring vring,
+					struct virtio_device *vdev,
+					bool weak_barriers,
+					bool ctx,
+					bool (*notify)(struct virtqueue *),
+					void (*callback)(struct virtqueue *),
+					const char *name);

WARNING: Unusual use of 'struct vmci_handle' on stack
#39: FILE: include/linux/vmw_vmci_api.h:39:
+int vmci_datagram_destroy_handle(struct vmci_handle handle);

---

 scripts/checkpatch.pl | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 34e4683de7a3..6ec86d8a4983 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6076,8 +6076,10 @@ sub process {
 # check for function definitions
 		if ($perl_version_ok &&
 		    defined $stat &&
-		    $stat =~ /^.\s*(?:$Storage\s+)?$Type\s*($Ident)\s*$balanced_parens\s*{/s) {
+		    $stat =~ /^.\s*(?:$Storage\s+)?$Type\s*($Ident)\s*$balanced_parens\s*([\{;])/s) {
 			$context_function = $1;
+			my $args = $2;
+			my $term = $3;
 
 # check for multiline function definition with misplaced open brace
 			my $ok = 0;
@@ -6088,12 +6090,25 @@ sub process {
 				$herectx .=  $rl . "\n";
 				$ok = 1 if ($rl =~ /^[ \+]\{/);
 				$ok = 1 if ($rl =~ /\{/ && $n == 0);
-				last if $rl =~ /^[ \+].*\{/;
+				last if ($rl =~ /^[ \+].*[\{;]/);
 			}
-			if (!$ok) {
+			if (!$ok || $term eq '{') {
 				ERROR("OPEN_BRACE",
 				      "open brace '{' following function definitions go on the next line\n" . $herectx);
 			}
+
+# check for struct or union uses on stack that might use struct or union *
+
+			while ($args =~ /(?:$Storage\s+)?($Type)\s*($Ident(?:\s*\[\s*\])?)?\s*,?/g) {
+				my $type = trim($1);
+				my $ident = defined($2) ? trim($2) : "";
+				if ($type =~ /(?:union|struct)/ &&
+				    !($type =~ /(?:\*|\bconst|\])$/ ||
+				      $ident =~ /\]$/)) {
+					WARN("AGGREGATE_ON_STACK",
+					     "Unusual use of '$type' on stack\n" . $herectx);
+				}
+			}
 		}
 
 # checks for new __setup's

