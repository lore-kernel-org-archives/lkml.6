Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbeFERG1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752271AbeFERGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:06:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Li Wei <liwei213@huawei.com>
Subject: [PATCH 4.9 19/61] scsi: ufs: fix failure to read the string descriptor
Date: Tue,  5 Jun 2018 19:01:40 +0200
Message-Id: <20180605170118.888128989@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Subhash Jadavani <subhashj@codeaurora.org>

commit bde44bb665d049468b6a1a2fa7d666434de4f83f upstream.

While reading variable size descriptors (like string descriptor), some UFS
devices may report the "LENGTH" (field in "Transaction Specific fields" of
Query Response UPIU) same as what was requested in Query Request UPIU
instead of reporting the actual size of the variable size descriptor.
Although it's safe to ignore the "LENGTH" field for variable size
descriptors as we can always derive the length of the descriptor from
the descriptor header fields. Hence this change impose the length match
check only for fixed size descriptors (for which we always request the
correct size as part of Query Request UPIU).

Reviewed-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[Wei Li: Slight tweaks to get the cherry-pick to apply,resolved collisions.]
Signed-off-by: Li Wei <liwei213@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ufs/ufshcd.c |   39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2086,18 +2086,41 @@ static int ufshcd_read_desc_param(struct
 					desc_id, desc_index, 0, desc_buf,
 					&buff_len);
 
-	if (ret || (buff_len < ufs_query_desc_max_size[desc_id]) ||
-	    (desc_buf[QUERY_DESC_LENGTH_OFFSET] !=
-	     ufs_query_desc_max_size[desc_id])
-	    || (desc_buf[QUERY_DESC_DESC_TYPE_OFFSET] != desc_id)) {
-		dev_err(hba->dev, "%s: Failed reading descriptor. desc_id %d param_offset %d buff_len %d ret %d",
-			__func__, desc_id, param_offset, buff_len, ret);
-		if (!ret)
-			ret = -EINVAL;
+	if (ret) {
+		dev_err(hba->dev, "%s: Failed reading descriptor. desc_id %d, desc_index %d, param_offset %d, ret %d",
+			__func__, desc_id, desc_index, param_offset, ret);
 
 		goto out;
 	}
 
+	/* Sanity check */
+	if (desc_buf[QUERY_DESC_DESC_TYPE_OFFSET] != desc_id) {
+		dev_err(hba->dev, "%s: invalid desc_id %d in descriptor header",
+			__func__, desc_buf[QUERY_DESC_DESC_TYPE_OFFSET]);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * While reading variable size descriptors (like string descriptor),
+	 * some UFS devices may report the "LENGTH" (field in "Transaction
+	 * Specific fields" of Query Response UPIU) same as what was requested
+	 * in Query Request UPIU instead of reporting the actual size of the
+	 * variable size descriptor.
+	 * Although it's safe to ignore the "LENGTH" field for variable size
+	 * descriptors as we can always derive the length of the descriptor from
+	 * the descriptor header fields. Hence this change impose the length
+	 * match check only for fixed size descriptors (for which we always
+	 * request the correct size as part of Query Request UPIU).
+	 */
+	if ((desc_id != QUERY_DESC_IDN_STRING) &&
+	    (buff_len != desc_buf[QUERY_DESC_LENGTH_OFFSET])) {
+		dev_err(hba->dev, "%s: desc_buf length mismatch: buff_len %d, buff_len(desc_header) %d",
+			__func__, buff_len, desc_buf[QUERY_DESC_LENGTH_OFFSET]);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (is_kmalloc)
 		memcpy(param_read_buf, &desc_buf[param_offset], param_size);
 out:
