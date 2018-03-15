Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeCOQuE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:50:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33515 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOQuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:50:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, Felix Kuehling <Felix.Kuehling@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Kent Russell <kent.russell@amd.com>, Amber Lin <Amber.Lin@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: fix uninitialized variable use
Date: Thu, 15 Mar 2018 17:49:40 +0100
Message-Id: <20180315164952.2168794-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:DXDVWqdHUhpt8IYnCpEKdljdDE2cuj2D+r14qiL5n9JWv7iTjH7
 ttBJZgoHWR9hzuiJndtzrPOo3y3sm/puK2TSfOr5OWxFyX2arAozWmotarw/V/ijwwIaFEv
 tDd4srvix8WonST20bKqFY/IK4GrVwXQstyQJBlTT6mX6FnOUJ2iVx7TA72jiJVKPatd7C+
 Tzb0d2JJ4CJX88A1sZe5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CJd0uI0sx7A=:wgPxTFgt+32Gc11OjIm1tm
 qxRo+ai8MTYH/aBwrA6FvD7DoI4ZehokGMOXbbp0+WEmTbuFyTYJQbLifewzR0tJOBUI25zJW
 /xej21sRaLJydXQi0/cguSq5vbPNKSv1dGUKPM5GNKY6vHrD6tA2I6ganICODuRQ8FeDI5IiN
 akze1TQDZ4VXc6IHOvnGEyxp0O7t8Bs+q4VaYOrVf2t6tQp1WB9GMRvDIYj9FKkAzSdYHtIc+
 e5A0dv4nlJfariFeHaS4Jq9/RAob6yCRv5k2JzZG7iweczvvpOWfkzEvJurHiGfYgTbU16U+h
 hf4ueENW6zBZ2xcPVF4DdQmt78bckbtkpMStZGWcmmQ64VoTUZqc6SpYwHo+6Owb1UB18L26c
 dVaajpvMGLNBrjLesxNfX8DKuwvQ0jpf4IsuB1zbKtKnC+0q5PK+7pdzhLElBwfe4KwGrCyl1
 Mg3pxs8c85Mms2lUQbOufIvxyTFBGciaEaxwB1fyVPCcnPV8+SXd/iFlCXq1rVe3DLsQNvTD1
 fgtSub6MN7ihOZpbp0ZH1cLQuJGWokHkhM0NzvVFhFkE1H6/X6lfT3wUdaP5M7t9wQUMiEoen
 uzQX8g8F+q3JRhg5OgKiYYP5dHxV7VO0iUap5RrQzxEnFbdwAinEhrIvZxCc4pTnejA5XCa8A
 yRl+fR7sKMh/a2WPGEsytkppZtCNQFvC25MaLWFPFWeVmuXjlcU0Ughqy8BWFx5RcGiE1U21G
 XjpcmO6GtC5B7SIF/zNcB6davwlyb40uc1W7Sw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_ACPI is disabled, we never initialize the acpi_table
structure in kfd_create_crat_image_virtual:

drivers/gpu/drm/amd/amdkfd/kfd_crat.c: In function 'kfd_create_crat_image_virtual':
drivers/gpu/drm/amd/amdkfd/kfd_crat.c:888:40: error: 'acpi_table' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The undefined behavior also happens for any other acpi_get_table()
failure, but then the compiler can't warn about it.

This adds an error check that prevents the structure from
being used in error, avoiding both the undefined behavior and
the warning about it.

Fixes: 520b8fb755cc ("drm/amdkfd: Add topology support for CPUs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 7493f47e7fe1..d85112224f1d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -882,7 +882,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	crat_table->length = sizeof(struct crat_header);
 
 	status = acpi_get_table("DSDT", 0, &acpi_table);
-	if (status == AE_NOT_FOUND)
+	if (status != AE_OK)
 		pr_warn("DSDT table not found for OEM information\n");
 	else {
 		crat_table->oem_revision = acpi_table->revision;
-- 
2.9.0
