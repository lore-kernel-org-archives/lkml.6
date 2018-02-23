Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2245NOnnm+DeBdYIBiEBZTbymvwZSj9SLlwr+hA4O/OBTg6u1Xq1SHHNaxEaY+y4dJYwi5PY
ARC-Seal: i=1; a=rsa-sha256; t=1519410875; cv=none;
        d=google.com; s=arc-20160816;
        b=SnELCSMleF/rJKGn9pmLGXl4rRAichr1FGGDvLlwCpq+axu1QWXHyJO6/qBn9NW4oj
         RtAw9NYQw8h5WSuEK3Deicr6+rx53Ebia/PjcXsGhayCZKA43j6k8xV75/MngrmejHd3
         pAQBJp0hCL4A4zqGkRvLti0ALJE/ZDVML9JpYAqQS6QjQ+GgWYIM7GrXSi+88p0tEMTB
         uq2QBes33Qu9K40wvTUlaZ2aI/5E3SPGKzljJKka+YvCSk0Fd/33n1AOZESju99zf284
         zFwH2Gqpe91CL1JtVheQzTYR1R9a5jbLzduWwR3ElQ8hIEKwIi1FbeOv/kjDLH4M42MC
         Uz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MSomPkusWW+yfVHgmrU2xPDM4UiUyUGrOWb2BvR3y2M=;
        b=OX/BKsLj5h/f+iAeEOmZgenzHeCjh15wbb8AqBEP2i6wu8TZsq1NiZDYqsZ0aNZi3+
         nhAWgXch9noUVEsy+dkOypyPv+JcMtyohHK3x6yJ0nXSwIYOL+LhMhILQ3uloOPfH0Sb
         pAV+6QdXuqp7Dtq2HHXbFTnL2n3w7t8GSWTaJlFUO4lhbTfjUgnIQ/GJv9eAslZii9eT
         Oo/VAEVP0GUZjYKnfvIbvnoERn9903n+Shxw5BXN9Q4IWLR16VSI/TJdwkWhP4Q6xRVc
         do5kD1G5zu2mfJw2s9qR3WBdQklMNzUZlyDT7MAd0K6vlP1kZY/S/FC0C+3z33exN4t+
         858w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 044/193] s390/dasd: prevent prefix I/O error
Date: Fri, 23 Feb 2018 19:24:37 +0100
Message-Id: <20180223170332.924158651@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217648861123641?=
X-GMAIL-MSGID: =?utf-8?q?1593217778537559868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Haberland <sth@linux.vnet.ibm.com>


[ Upstream commit da340f921d3454f1521671c7a5a43ad3331fbe50 ]

Prevent that a prefix flag is set based on invalid configuration data.
The validity.verify_base flag should only be set for alias devices.
Usually the unit address type is either one of base, PAV alias or
HyperPAV alias. But in cases where the unit address type is not set or
any other value the validity.verify_base flag might be set as well.
This would lead to follow on errors.
Explicitly check for alias devices and set the validity flag only for
them.

Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_eckd.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -518,10 +518,12 @@ static int prefix_LRE(struct ccw1 *ccw,
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
-	if (startpriv->uid.type != UA_BASE_DEVICE) {
+	if (startpriv->uid.type == UA_BASE_PAV_ALIAS)
 		pfxdata->validity.verify_base = 1;
-		if (startpriv->uid.type == UA_HYPER_PAV_ALIAS)
-			pfxdata->validity.hyper_pav = 1;
+
+	if (startpriv->uid.type == UA_HYPER_PAV_ALIAS) {
+		pfxdata->validity.verify_base = 1;
+		pfxdata->validity.hyper_pav = 1;
 	}
 
 	/* define extend data (mostly)*/
@@ -3002,10 +3004,12 @@ static int prepare_itcw(struct itcw *itc
 	pfxdata.validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
-	if (startpriv->uid.type != UA_BASE_DEVICE) {
+	if (startpriv->uid.type == UA_BASE_PAV_ALIAS)
+		pfxdata.validity.verify_base = 1;
+
+	if (startpriv->uid.type == UA_HYPER_PAV_ALIAS) {
 		pfxdata.validity.verify_base = 1;
-		if (startpriv->uid.type == UA_HYPER_PAV_ALIAS)
-			pfxdata.validity.hyper_pav = 1;
+		pfxdata.validity.hyper_pav = 1;
 	}
 
 	switch (cmd) {
