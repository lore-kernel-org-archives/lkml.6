Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165373AbeE1N0a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161305AbeE1Kr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:47:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@icloud.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 153/496] libceph, ceph: avoid memory leak when specifying same option several times
Date: Mon, 28 May 2018 11:58:58 +0200
Message-Id: <20180528100326.345914664@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengguang Xu <cgxu519@icloud.com>

[ Upstream commit 937441f3a3158d5510ca8cc78a82453f57a96365 ]

When parsing string option, in order to avoid memory leak we need to
carefully free it first in case of specifying same option several times.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/super.c        |    2 ++
 net/ceph/ceph_common.c |    7 +++++++
 2 files changed, 9 insertions(+)

--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -224,6 +224,7 @@ static int parse_fsopt_token(char *c, vo
 			return -ENOMEM;
 		break;
 	case Opt_mds_namespace:
+		kfree(fsopt->mds_namespace);
 		fsopt->mds_namespace = kstrndup(argstr[0].from,
 						argstr[0].to-argstr[0].from,
 						GFP_KERNEL);
@@ -231,6 +232,7 @@ static int parse_fsopt_token(char *c, vo
 			return -ENOMEM;
 		break;
 	case Opt_fscache_uniq:
+		kfree(fsopt->fscache_uniq);
 		fsopt->fscache_uniq = kstrndup(argstr[0].from,
 					       argstr[0].to-argstr[0].from,
 					       GFP_KERNEL);
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -418,11 +418,15 @@ ceph_parse_options(char *options, const
 				opt->flags |= CEPH_OPT_FSID;
 			break;
 		case Opt_name:
+			kfree(opt->name);
 			opt->name = kstrndup(argstr[0].from,
 					      argstr[0].to-argstr[0].from,
 					      GFP_KERNEL);
 			break;
 		case Opt_secret:
+			ceph_crypto_key_destroy(opt->key);
+			kfree(opt->key);
+
 		        opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
 			if (!opt->key) {
 				err = -ENOMEM;
@@ -433,6 +437,9 @@ ceph_parse_options(char *options, const
 				goto out;
 			break;
 		case Opt_key:
+			ceph_crypto_key_destroy(opt->key);
+			kfree(opt->key);
+
 		        opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
 			if (!opt->key) {
 				err = -ENOMEM;
