Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvkaicKIhGlc93RMO8a6SvcjQ3k7aU0PnYLpPtervo8gtdXjHyuRRPMcHU7HI5rohtYq4Oc
ARC-Seal: i=1; a=rsa-sha256; t=1521483382; cv=none;
        d=google.com; s=arc-20160816;
        b=rP6P9TfOLBUW5ZOzl0velnemsxnmAcN2c2IVzEfsy0Pp3J95bCManYIU/7EjDdgeo7
         2EYKrisak9klL57G1EdPGdWibMn0dV/pJXggfiG9DuzAlX0O7qg9Fb48AMR8zTbn4ytI
         N/Fhisqvm5oRv1jofAoyXG9DrKYBD0+hW4FcsNdcDgh+YvFOp+50O0zg8AzfXOyhnvX8
         DoN9N6kbmD+HLdzPBVs2/hqa+8aESamplNOCp2eUad5+b9n1Ac941kXpXQ6SJwMrsA7j
         Y047756RQDNqAn3kp/o0WFr0ebp+pqyK0nnFyaCgTgG+4Vf05H56McZDqyZdSTOrgmjb
         4HVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rwg4X/arFlStzNgsQ7LWLxQ/Dd9J4yN1hl4uzpIN/1A=;
        b=pN3tPglirQm3sGELJPeSS63+NdB7spEaTKigt94R7eUlfimZ2B0o1iJ74ZdItqleEr
         7p3wC7aonfPErgrrD25YD/QeSQB36fG1U4PLZ6/MfNW+6OYucRmW2PcXEcewwFPzxtVR
         DRNEJ17gzGSMAsgxTvZya1bunjTZB2k//vNMt687Dg8ROOvzH6qtZg2mtJISanVFrBg4
         fjt6G8vc4RQ1bS+ukGxU9Tyt4GHF3j1ZLvxi5JjMjVJAvDvz13JxP372WaxJ1IY8p1+R
         b/8pEMXShQ9nSK4geUbAxfdStG7XWzld0uXpDMy2cMcSOWQsLu2mPrzgeJ43OEkk5l4y
         07mw==
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
Subject: [PATCH 4.4 102/134] drm/amdkfd: Fix memory leaks in kfd topology
Date: Mon, 19 Mar 2018 19:06:25 +0100
Message-Id: <20180319171903.960738779@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390959351376551?=
X-GMAIL-MSGID: =?utf-8?q?1595390959351376551?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
