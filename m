Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C698C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236A02147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfA2N2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:28:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbfA2N2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:28:05 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TDKeUe062864
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:28:04 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qamdd3adj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:27:42 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <joeln@il.ibm.com>;
        Tue, 29 Jan 2019 13:27:04 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 13:27:02 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TDR0SR7602550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 13:27:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42DBD5204E;
        Tue, 29 Jan 2019 13:27:00 +0000 (GMT)
Received: from tal (unknown [9.148.32.96])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 9EFA85204F;
        Tue, 29 Jan 2019 13:26:58 +0000 (GMT)
Received: by tal (sSMTP sendmail emulation); Tue, 29 Jan 2019 15:26:58 +0200
From:   Joel Nider <joeln@il.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Nider <joeln@il.ibm.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] RDMA/uverbs: add UVERBS_METHOD_REG_REMOTE_MR
Date:   Tue, 29 Jan 2019 15:26:26 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
References: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012913-4275-0000-0000-000003075177
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012913-4276-0000-0000-0000381553B8
Message-Id: <1548768386-28289-6-git-send-email-joeln@il.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new handler for new uverb reg_remote_mr. The purpose is to register
a memory region in a different address space (i.e. process) than the
caller.

The main use case which motivated this change is post-copy container
migration. When a migration manager (i.e. CRIU) starts a migration, it
must have an open connection for handling any page faults that occur
in the container after restoration on the target machine. Even though
CRIU establishes and maintains the connection, ultimately the memory
is copied from the container being migrated (i.e. a remote address
space). This container must remain passive -- meaning it cannot have
any knowledge of the RDMA connection; therefore the migration manager
must have the ability to register a remote memory region. This remote
memory region will serve as the source for any memory pages that must
be copied (on-demand or otherwise) during the migration.

Signed-off-by: Joel Nider <joeln@il.ibm.com>
---
 drivers/infiniband/core/uverbs_std_types_mr.c | 129 +++++++++++++++++++++++++-
 include/rdma/ib_verbs.h                       |   8 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  13 +++
 3 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 4d4be0c..bf7b4b2 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -150,6 +150,99 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	return ret;
 }
 
+static int UVERBS_HANDLER(UVERBS_METHOD_REG_REMOTE_MR)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct pid *owner_pid;
+	struct ib_reg_remote_mr_attr attr = {};
+	struct ib_uobject *uobj =
+		uverbs_attr_get_uobject(attrs,
+					UVERBS_ATTR_REG_REMOTE_MR_HANDLE);
+	struct ib_pd *pd =
+		uverbs_attr_get_obj(attrs, UVERBS_ATTR_REG_REMOTE_MR_PD_HANDLE);
+
+	struct ib_mr *mr;
+	int ret;
+
+	ret = uverbs_copy_from(&attr.start, attrs,
+				UVERBS_ATTR_REG_REMOTE_MR_START);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&attr.length, attrs,
+				UVERBS_ATTR_REG_REMOTE_MR_LENGTH);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&attr.hca_va, attrs,
+				UVERBS_ATTR_REG_REMOTE_MR_HCA_VA);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&attr.owner, attrs,
+				UVERBS_ATTR_REG_REMOTE_MR_OWNER);
+	if (ret)
+		return ret;
+
+	ret = uverbs_get_flags32(&attr.access_flags, attrs,
+				 UVERBS_ATTR_REG_REMOTE_MR_ACCESS_FLAGS,
+				 IB_ACCESS_SUPPORTED);
+	if (ret)
+		return ret;
+
+	/* ensure the offsets are identical */
+	if ((attr.start & ~PAGE_MASK) != (attr.hca_va & ~PAGE_MASK))
+		return -EINVAL;
+
+	ret = ib_check_mr_access(attr.access_flags);
+	if (ret)
+		return ret;
+
+	if (attr.access_flags & IB_ACCESS_ON_DEMAND) {
+		if (!(pd->device->attrs.device_cap_flags &
+		      IB_DEVICE_ON_DEMAND_PAGING)) {
+			pr_debug("ODP support not available\n");
+			ret = -EINVAL;
+			return ret;
+		}
+	}
+
+	/* get the owner's pid struct before something happens to it */
+	owner_pid = find_get_pid(attr.owner);
+	mr = pd->device->ops.reg_user_mr(pd, attr.start, attr.length,
+		attr.hca_va, attr.access_flags, owner_pid, NULL);
+	if (IS_ERR(mr))
+		return PTR_ERR(mr);
+
+	mr->device  = pd->device;
+	mr->pd      = pd;
+	mr->dm	    = NULL;
+	mr->uobject = uobj;
+	atomic_inc(&pd->usecnt);
+	mr->res.type = RDMA_RESTRACK_MR;
+	mr->res.task = get_pid_task(owner_pid, PIDTYPE_PID);
+	rdma_restrack_kadd(&mr->res);
+
+	uobj->object = mr;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_REMOTE_MR_RESP_LKEY,
+		   &mr->lkey, sizeof(mr->lkey));
+	if (ret)
+		goto err_dereg;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_REMOTE_MR_RESP_RKEY,
+			&mr->rkey, sizeof(mr->rkey));
+	if (ret)
+		goto err_dereg;
+
+	return 0;
+
+err_dereg:
+	ib_dereg_mr(mr);
+
+	return ret;
+}
+
 DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_METHOD_ADVISE_MR,
 	UVERBS_ATTR_IDR(UVERBS_ATTR_ADVISE_MR_PD_HANDLE,
@@ -203,12 +296,46 @@ DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 			UVERBS_ACCESS_DESTROY,
 			UA_MANDATORY));
 
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_REG_REMOTE_MR,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_REMOTE_MR_HANDLE,
+			UVERBS_OBJECT_MR,
+			UVERBS_ACCESS_NEW,
+			UA_MANDATORY),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_REMOTE_MR_PD_HANDLE,
+			UVERBS_OBJECT_PD,
+			UVERBS_ACCESS_READ,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_REMOTE_MR_START,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_REMOTE_MR_LENGTH,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_REMOTE_MR_HCA_VA,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_REG_REMOTE_MR_ACCESS_FLAGS,
+			     enum ib_access_flags),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_REMOTE_MR_OWNER,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_REG_REMOTE_MR_RESP_LKEY,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_REG_REMOTE_MR_RESP_RKEY,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+);
+
 DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_OBJECT_MR,
 	UVERBS_TYPE_ALLOC_IDR(uverbs_free_mr),
 	&UVERBS_METHOD(UVERBS_METHOD_DM_MR_REG),
 	&UVERBS_METHOD(UVERBS_METHOD_MR_DESTROY),
-	&UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR));
+	&UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR),
+	&UVERBS_METHOD(UVERBS_METHOD_REG_REMOTE_MR),
+);
 
 const struct uapi_definition uverbs_def_obj_mr[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_MR,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3432404..dcf5edc 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -334,6 +334,14 @@ struct ib_dm_alloc_attr {
 	u32	flags;
 };
 
+struct ib_reg_remote_mr_attr {
+	u64      start;
+	u64      length;
+	u64      hca_va;
+	u32      access_flags;
+	u32      owner;
+};
+
 struct ib_device_attr {
 	u64			fw_ver;
 	__be64			sys_image_guid;
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 64f0e3a..4e62cd4 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -150,10 +150,23 @@ enum uverbs_attrs_reg_dm_mr_cmd_attr_ids {
 	UVERBS_ATTR_REG_DM_MR_RESP_RKEY,
 };
 
+enum uverbs_attrs_reg_remote_mr_cmd_attr_ids {
+	UVERBS_ATTR_REG_REMOTE_MR_HANDLE,
+	UVERBS_ATTR_REG_REMOTE_MR_PD_HANDLE,
+	UVERBS_ATTR_REG_REMOTE_MR_START,
+	UVERBS_ATTR_REG_REMOTE_MR_LENGTH,
+	UVERBS_ATTR_REG_REMOTE_MR_HCA_VA,
+	UVERBS_ATTR_REG_REMOTE_MR_ACCESS_FLAGS,
+	UVERBS_ATTR_REG_REMOTE_MR_OWNER,
+	UVERBS_ATTR_REG_REMOTE_MR_RESP_LKEY,
+	UVERBS_ATTR_REG_REMOTE_MR_RESP_RKEY,
+};
+
 enum uverbs_methods_mr {
 	UVERBS_METHOD_DM_MR_REG,
 	UVERBS_METHOD_MR_DESTROY,
 	UVERBS_METHOD_ADVISE_MR,
+	UVERBS_METHOD_REG_REMOTE_MR,
 };
 
 enum uverbs_attrs_mr_destroy_ids {
-- 
2.7.4

