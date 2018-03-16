Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtLjq5i6+B6903JFdAUG4pIZEiGiBQtplaMVEH21SUvCbo4a6T3nQqWPV7TD1KGvrYhlQQi
ARC-Seal: i=1; a=rsa-sha256; t=1521214683; cv=none;
        d=google.com; s=arc-20160816;
        b=DxYfHyjRykx4KwiwQruQh2jon/XFOTwRr2gi+UkTPD1K3MThSz1+lOdA9FYzjGgGQb
         CYv3N4uyP4/uLe/OpOCEOcO51sg3Vmyp4hh6zLwk5/5jwgTSfn7MBzMsGLodmfHXetPK
         n4IuOnTQ90kSsMx986KXvvMtty7nxXaiMIwfFBfJfW/ZPaFAbSXweshYdxQluiYbLwOR
         gJBW6gm+o1SayeTaDuafUVUP1Ni/ZliLXaAFozOURnQ0K/G6qCSpYAUFP8GnZDcDmfzG
         /Sbnb/+MZoeu0zHR5sooON3WetZuWB1ttAOp1G1twQhgVPfnwnq3BRgUQKHAfk6DHsud
         J8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fJaHUCOZ07aa2qEyGZP3vRHmtGBQlxt4mv/wad9QdZQ=;
        b=MEL/mUFos069/bs8Z5ttIqXc71RD8xddTSpsTPkxNCM72ZZambtk8o7W5L3nGIzHR5
         i9bRcWkgmhRaO350Dr1UYe07b3zAax3+kvsYLf0oJwts/gK14Y2wb201l/B3bkV9o4u4
         X/cfKtb3HA27nwL1Fwd4yRSmvpwdiEIPE7Nh1IbSmqmmzrKx3TuRF6/cnxouVEMfFwCS
         pq/6Gky8a5Cv7vHfCqZ2xktfBzofqa0KoCK5mAZKf8HbuYiK+AEC14R6go0ZOuPSXsIV
         FVFQ9mndsLfnYvfxeAVg5WnIThVFWZ5p4qLc+4MdzpbvmDbt4Gp8E3DRpav+BUITmqDT
         e0yg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yong Zhao <yong.zhao@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Oded Gabbay <oded.gabbay@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 092/109] drm/amdkfd: Fix memory leaks in kfd topology
Date: Fri, 16 Mar 2018 16:24:01 +0100
Message-Id: <20180316152334.916800946@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109208601226104?=
X-GMAIL-MSGID: =?utf-8?q?1595109208601226104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yong Zhao <yong.zhao@amd.com>


[ Upstream commit 5108d768408abc80e4e8d99f5b406a73cb04056b ]

Kobject created using kobject_create_and_add() can be freed using
kobject_put() when there is no referenece any more. However,
kobject memory allocated with kzalloc() has to set up a release
callback in order to free it when the counter decreases to 0.
Otherwise it causes memory leak.

Signed-off-by: Yong Zhao <yong.zhao@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -501,11 +501,17 @@ static ssize_t sysprops_show(struct kobj
 	return ret;
 }
 
+static void kfd_topology_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct sysfs_ops sysprops_ops = {
 	.show = sysprops_show,
 };
 
 static struct kobj_type sysprops_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &sysprops_ops,
 };
 
@@ -541,6 +547,7 @@ static const struct sysfs_ops iolink_ops
 };
 
 static struct kobj_type iolink_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &iolink_ops,
 };
 
@@ -568,6 +575,7 @@ static const struct sysfs_ops mem_ops =
 };
 
 static struct kobj_type mem_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &mem_ops,
 };
 
@@ -607,6 +615,7 @@ static const struct sysfs_ops cache_ops
 };
 
 static struct kobj_type cache_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &cache_ops,
 };
 
@@ -729,6 +738,7 @@ static const struct sysfs_ops node_ops =
 };
 
 static struct kobj_type node_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &node_ops,
 };
 
