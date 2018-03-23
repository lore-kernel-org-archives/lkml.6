Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuQ1YnTR23o8SCei8sWsax4Z10y1Hysj6AnHlqikofkEiaFzSb0jJINBYHByRbCl9g80cJj
ARC-Seal: i=1; a=rsa-sha256; t=1521800169; cv=none;
        d=google.com; s=arc-20160816;
        b=PRaK7ZutuE2XccIZT5v4O6Vo056wUQTE9cyL/Plt3NsyHws3Ejkbn/N8E8Myb11og0
         Htkxl61NarIELcBFzFJlDk2PYeUmF+QdV8RA6cClQyro/WwK2nRF/mpHsPAYoBrDm7cp
         zt7SjDFxMGIm4M7877oFvTUAuMZkz1TGVv5RF9k+vHzoh8/MzHOr9VduAEm19pUOgeUx
         ukUHdN6ZfoyzuzrR3DRxQjlC+GYTzVITSm7HQfphlJ2BKgMQqAyWC64CSfTT5BTULAdD
         4JwJcwXLTpQV6Bwj+uSTXo9m1BXTP7IcYjxyFRpvzsN8xqI14NAKj5r/4WXcW6NuJzqT
         1gAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VLXttpuRcNoJ8PQh/5kD7pRTPsH5wbbJtNCZ/rHWGTY=;
        b=yRgDDGnt0rJtWmcc77gk4jPSVOgqX6P5EDjfUZhEsWor8H9bIDXVeVOnhOGl+o/Z73
         0udaE+W+YOh7r3KtJlQQf9RffVipDpFZ69Ajrp4DioixEtksyPdL4ttMYIDVAHpdnVur
         /dXoW3wlSfVVBma9oEY1Miy9ZwrJ8AM7X4T7XzSc1C3DMYxd9uN4NAPCGMTve3HPDGD3
         mRwpfNOgwDTp7QbaminlKL032ErTb56Zqp/Tsg1VJ3P3JDsyv/L+Ly9kte//bKFiBJgN
         Xm34Lh3RHk8z9JMxk2OxwhQ0xDOl2DTD7SfJUE0GN4kE1O3dcEoU8QQLSUUl6X03pVlZ
         WIew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Monakhov <dmonakhov@openvz.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 65/97] tcm_fileio: Prevent information leak for short reads
Date: Fri, 23 Mar 2018 10:54:52 +0100
Message-Id: <20180323094201.280440066@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722718647459874?=
X-GMAIL-MSGID: =?utf-8?q?1595723134786948235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Monakhov <dmonakhov@openvz.org>


[ Upstream commit f11b55d13563e9428c88c873f4f03a6bef11ec0a ]

If we failed to read data from backing file (probably because some one
truncate file under us), we must zerofill cmd's data, otherwise it will
be returned as is. Most likely cmd's data are unitialized pages from
page cache. This result in information leak.

(Change BUG_ON into -EINVAL se_cmd failure - nab)

testcase: https://github.com/dmonakhov/xfstests/commit/e11a1b7b907ca67b1be51a1594025600767366d5
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_file.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -276,12 +276,11 @@ static int fd_do_rw(struct se_cmd *cmd,
 	else
 		ret = vfs_iter_read(fd, &iter, &pos);
 
-	kfree(bvec);
-
 	if (is_write) {
 		if (ret < 0 || ret != data_length) {
 			pr_err("%s() write returned %d\n", __func__, ret);
-			return (ret < 0 ? ret : -EINVAL);
+			if (ret >= 0)
+				ret = -EINVAL;
 		}
 	} else {
 		/*
@@ -294,17 +293,29 @@ static int fd_do_rw(struct se_cmd *cmd,
 				pr_err("%s() returned %d, expecting %u for "
 						"S_ISBLK\n", __func__, ret,
 						data_length);
-				return (ret < 0 ? ret : -EINVAL);
+				if (ret >= 0)
+					ret = -EINVAL;
 			}
 		} else {
 			if (ret < 0) {
 				pr_err("%s() returned %d for non S_ISBLK\n",
 						__func__, ret);
-				return ret;
+			} else if (ret != data_length) {
+				/*
+				 * Short read case:
+				 * Probably some one truncate file under us.
+				 * We must explicitly zero sg-pages to prevent
+				 * expose uninizialized pages to userspace.
+				 */
+				if (ret < data_length)
+					ret += iov_iter_zero(data_length - ret, &iter);
+				else
+					ret = -EINVAL;
 			}
 		}
 	}
-	return 1;
+	kfree(bvec);
+	return ret;
 }
 
 static sense_reason_t
