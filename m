Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuUHN0rayp7jpGCyzzm9gttzbQDtfR1pazyAlZt0syApn7oJkLJobaDVJgYtCclPHKJ+JAn
ARC-Seal: i=1; a=rsa-sha256; t=1521484015; cv=none;
        d=google.com; s=arc-20160816;
        b=BhERVZUxzIwxbwjDQewCNYJZ6r+ooNMaj1zU9X7bVwdPhXA87c/6/zx1Y0Lvppmovh
         w31z4iIHDnXj0EOzUEi9UiMG0lfXmCUWYyMMzPxVwt0kB29wdUMUMk6oq+YHFDza1CHV
         Q0OE+yxVmYEJ8xjZhlA6FzEikhlrWnNzQe5Y48i2KI6vUjLPry9A2FdyGrIpekOnyr/i
         qrh/6htBOCndrgNiCCsfOCJlAfywaFFwhFUD1qsLsBnMRW9PTu5ekchXqt1+yYO+AeQ+
         KvBEEQg8+bJ2sku867qRmxTmGzmla3Bv5NTVq6ByiNrUD7xicUZ+1pGSLavFEA9rrlGr
         eg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Xe2FemhjG4307yK4iFuPt7kiT/c4Vd25ZLKkBJzvMoo=;
        b=F83St+2t2huUC0S4uM2Lyi4j1sIMolptJJ/FLf8JqkmOrMGXrWmb0W+EHQjHc9oD+E
         p8LRn17k/VkL4Ud5gSfINnh0wD4VkY0SCN/jk7jsvk1h2BSJsYDk1xt8bxPqWOJrm//C
         t3+qm8BBQBxM64U0gM+T/TwnA/QXNOhNo8dzfPY9mJbQ7AUJhv7AlvsLPjyqYDR2+3k1
         gnhFzAcMCX6iIU4wuol7wezW1+aHdj/BPXr8urrVNqrLv9HUh9H2VvbXudy3CnW5sHTX
         Uq69TR6QF6hLuZztTNfIAbV0HzL7sSLFFSy6fZFJHRPi82XdoeldndGAWlZjdnYRzYfA
         ZMbQ==
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
Subject: [PATCH 4.9 200/241] drm/amdkfd: Fix memory leaks in kfd topology
Date: Mon, 19 Mar 2018 19:07:45 +0100
Message-Id: <20180319180759.469174407@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390959351376551?=
X-GMAIL-MSGID: =?utf-8?q?1595391622171767363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -519,11 +519,17 @@ static ssize_t sysprops_show(struct kobj
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
 
@@ -559,6 +565,7 @@ static const struct sysfs_ops iolink_ops
 };
 
 static struct kobj_type iolink_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &iolink_ops,
 };
 
@@ -586,6 +593,7 @@ static const struct sysfs_ops mem_ops =
 };
 
 static struct kobj_type mem_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &mem_ops,
 };
 
@@ -625,6 +633,7 @@ static const struct sysfs_ops cache_ops
 };
 
 static struct kobj_type cache_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &cache_ops,
 };
 
@@ -747,6 +756,7 @@ static const struct sysfs_ops node_ops =
 };
 
 static struct kobj_type node_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &node_ops,
 };
 
