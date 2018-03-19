Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvAnv/l67zqALPDfNNK9mSMkFXrHyq9Pszz3DfOKlJ83YboUMHae7k4knH8Y28CLROFH3gv
ARC-Seal: i=1; a=rsa-sha256; t=1521483966; cv=none;
        d=google.com; s=arc-20160816;
        b=G07Vh+Rg3V00vRIkxhEEzxJOSpjO/rbH88myHqXP8X6HY0i7k1KZ2umVr0zFtzxK31
         Jvhm3GcCV9pMr0YFYbhb4cNSFlicF0y9lXEE/O2KLmbI6ciKj1CiYSzXtgkfcdLMsZ2s
         fS59xTjB1dOK4TzcRq3Jg5PF4ThcJXlrDPrFxOs5xPSv5sgVOpelv7G1QZXinXrUaxRR
         aVNf1B/ghUlxiyDqZ0RmKthPS8+p6DJH02f/Rpve+i+quZNO65V6gWWQDUVYF4D515NS
         VLXhNNw5ttqE6OqiP4yz0cUQ4m7+QTOZAMOvQQ1FOP+qry91xsweGsr0kAiN8WfnVX1m
         ttsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D4Z2YFpxYtjjbl9u94v+o1XwmsqNloPr77NKCcVoFE0=;
        b=nXzOFmCA+iu5pxqmkft3LAndL5LNBLg/ToEMxyq4T8E2QstEcfY0Zxu9zxxokPgBBc
         IXKfRNbACnNlp7a6A0WG1KlZV3glOw1ge6yDFGaojYkh8YCs5xff0AdfPXuo5MF9ybsQ
         hFCfDw6zQTpJlH5S8STsyDz9ur/fJlpJpWSb03eBgzBv2dJlQyxGPymIICc85Hq399ls
         8uyRO+gQe9qS0x1V10XciRz+7oXnZ3Z5DtqiC83Y4tEfKepYVsAKe3QriHfIw4XwwJKP
         lSXsk8pQfd6rvYuLyI4RxFNifm3GIolDudrVVJVOE/5iTyE5d4JoMOTBn1KCWkzzCqZ4
         9Vbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 147/241] vfio/powerpc/spapr_tce: Enforce IOMMU type compatibility check
Date: Mon, 19 Mar 2018 19:06:52 +0100
Message-Id: <20180319180757.272609289@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391571138548957?=
X-GMAIL-MSGID: =?utf-8?q?1595391571138548957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kardashevskiy <aik@ozlabs.ru>


[ Upstream commit 1282ba7fc28dbc66c3f0e4aaafaaa228361d1ae5 ]

The existing SPAPR TCE driver advertises both VFIO_SPAPR_TCE_IOMMU and
VFIO_SPAPR_TCE_v2_IOMMU types to the userspace and the userspace usually
picks the v2.

Normally the userspace would create a container, attach an IOMMU group
to it and only then set the IOMMU type (which would normally be v2).

However a specific IOMMU group may not support v2, in other words
it may not implement set_window/unset_window/take_ownership/
release_ownership and such a group should not be attached to
a v2 container.

This adds extra checks that a new group can do what the selected IOMMU
type suggests. The userspace can then test the return value from
ioctl(VFIO_SET_IOMMU, VFIO_SPAPR_TCE_v2_IOMMU) and try
VFIO_SPAPR_TCE_IOMMU.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vfio/vfio_iommu_spapr_tce.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -1332,8 +1332,16 @@ static int tce_iommu_attach_group(void *
 
 	if (!table_group->ops || !table_group->ops->take_ownership ||
 			!table_group->ops->release_ownership) {
+		if (container->v2) {
+			ret = -EPERM;
+			goto unlock_exit;
+		}
 		ret = tce_iommu_take_ownership(container, table_group);
 	} else {
+		if (!container->v2) {
+			ret = -EPERM;
+			goto unlock_exit;
+		}
 		ret = tce_iommu_take_ownership_ddw(container, table_group);
 		if (!tce_groups_attached(container) && !container->tables[0])
 			container->def_window_pending = true;
