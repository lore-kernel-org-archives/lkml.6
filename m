Return-Path: <anuragku@xilinx.com>
X-Google-Smtp-Source: AG47ELsdo9HiCtFBzodMmpaOucCTrvqfBxiE4VwCqZpcu/PpOe9wHnwjFd9UZlssGIKmWj3PuADi
ARC-Seal: i=1; a=rsa-sha256; t=1521442281; cv=none;
        d=google.com; s=arc-20160816;
        b=RqzFCYN6aBfdq2MHmoCSEl5ot9WygMEgK0oHyU2CvCztFSnd9KOwerLUqZ+nRTl5wQ
         D9kwjb2gG0bXmyUk2KKODzMVsxVF0ggkSYGb1urLsSs4pBsAtG6GFx0SfNOEsE864qUT
         VZJfOXDELhbQEEPGAq63ECdyJxa5lDxyPkmTAXfJuIAEP7HTobYWoyu1EW4oA4C37m1O
         cIaWPklKAYvZ6senPkeYPA1l/Fhp36M5VdM5axadP/BwWjd7NF8121gqQ0ygU+wG+qeT
         aUQ3BHy20ac6zU+tPyncN93wcIMzP0+dc24El3ADnFonPaLon7xVn7dbhwh14W30cbaF
         GeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=qIQv3vsJvl5YhcmpZ8/jW3JBdYZlDkG9yDgmWIyLuEY=;
        b=tnZFCGC7F4k9DBYTXGmF6EFmXnNe6V8bxy5xvu6j5gTB+Wwd7p+prdu1QQXaui9Pv0
         YeJChFRYjA4gnRIpDU3ekX/EACydIVJunf+bUFwsCnI/yYvL2Hr9p3D4Lt/pTZDQQ26l
         zymH8/+EcZvIZCTyiHSJn0RY5MyqLiCKg/uj0eZ/oWkwRFcHph8jVJOJsl1Ey172/sLu
         4V2QXX85BkBkgKPMdRGTckeEXlSfCn8MwDvocIbQXfYsUPqvNFVmgdeL5R5FMbUTAw9I
         80aBcZiwGOMJ6cZ+8IeulWyVp4DPrRM/ovDjhHmi1U4im0LXvKKn3nPqybWjNUYNqBZC
         +3iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=Z5CVZZs3;
       spf=pass (google.com: domain of anuragku@xilinx.com designates 104.47.32.43 as permitted sender) smtp.mailfrom=anuragku@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=Z5CVZZs3;
       spf=pass (google.com: domain of anuragku@xilinx.com designates 104.47.32.43 as permitted sender) smtp.mailfrom=anuragku@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To: Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <v.anuragkumar@gmail.com>, <APANDEY@xilinx.com>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Anurag Kumar
 Vulisha <anuragku@xilinx.com>
Subject: [PATCH] usb: dwc3: gadget: Correct the logic for queuing sgs
Date: Mon, 19 Mar 2018 12:20:53 +0530
Message-ID: <1521442253-15906-1-git-send-email-anuragku@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(39380400002)(2980300002)(438002)(189003)(199004)(48376002)(51416003)(52956003)(5660300001)(2906002)(356003)(36756003)(305945005)(426003)(8936002)(50226002)(5890100001)(478600001)(4326008)(103686004)(63266004)(36386004)(90966002)(42186006)(8676002)(1857600001)(110136005)(39060400002)(8746002)(54906003)(336012)(316002)(106466001)(107886003)(6266002)(26005)(106002)(81166006)(81156014)(47776003)(50466002)(6666003)(186003)(59450400001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2268;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT017;1:GxuAa3dGdUojnQWQROxif5JvLFufRWIbubZMct9C1OxozG6HwlSozXAS8GZp7vwE0bbW7J3jPFUscKzpJS6rRvbFqA/39FfqG9HvBv5E92hBSCWuAnpQqsuIGxu4z8UX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6748be4d-e819-4f14-8949-08d58d65d116
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR02MB2268;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2268;3:NUKnKKT+40dZlxIJp2Zdfit5nPrhdE0ew+nUBfnZLAj7LHfpkib2qKgREiLG0ThHQ4ILog1w8X1XnSNXXO06E10KZDayGqlhI+MklAvwjkB0/PapLTI01xrBl19USaJMCMCLudJbX2Y1JPOsOdQWuVLfeitgZnkw9ZPSZMZDwUydyfz+d8HFI0agQTzkNs+TEae/b4rQdY/SquV8r6eMB2JrlcMUkS9RBGhkMZNBnHaank9+zuWJ1E2AhYUu5JqCz0RdYW9/IukZuG+D7zibbafhsuiBCK14xtX/EOZi81Mk5iJJeRVH+4gvuQulGX7EiQLc59zI0LTDcWsgIinHupdqJ4hp94Rr5MAUQPwFuW0=;25:KY7qKgPuf9AFySm3aOkQEfShDNm0MllnfovJJxQYQ9puKKxlVzZ0BSzpJARtvUtWVP1nM7T2s4/8fvNH8pxgpxN7dW0JEV3A5DdeinkW1sLrXYN6wbqwy/Wp1F/CA02n88dmYRg08XmhVJzSEfy8bTjg3Awo/MqeFurPu9aIwwGuxiESD9VTRYSf1mJm3277FBMLlwyp+f7VKZtS22ueJse/i54AMrAd0zcA+RD5fbGEtGERiCJTQe/UTMtRzW59E4EFT4TH12JKWjrGo3M1p5TpJyuIm+f8P/XjgzcbSnUkDmImA1QJaKLUsru1KF3gdFEgeioN5zQx9xSIAs8Ahg==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2268:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2268;31:KyCe+ahSAUE7U0qWI9ShydnO6ek1oKvjpjneIdBmpTOVjpGfeD9t8LdFNWsRsfWmRxbvAeCdAndyhpZjyKQmOOVuADhDmD1yfz87k0jIP2mnBxMYopSsnR2F8+P7STCS2W62E5tsIqpPpS07HxYWtMshC19YRsVScTIErmoORRp2aZ0lZU/0IXR8qfLZqQkmbbUW1QHd1EdJ8jwf8BYNRXLWWeDNOEioR7L/BIUcXvA=;20:Cryr9200sPTb9A8yv7IAMmPcCPJHghHEom7sU3AR945EJj/OEl02M52wmGlc7VjZ0rVgeeSlai35MzKwT6Xk6bCZN7UqlDcRNF/uVbacbz+JLW248TUDJVQk/3LaKiayGv0BvPbYaZzhn4eMy/hY9Nq7Z5KnaciWhqSGHot43N6e/CIgXdM7E4hTAp/SUGlIaYdK8kK0G7WuaOVRoEa9fvf/vTllD2HyxNSRMNxIf6FpvL0p6ww+8ZNCRJDpi1KEvpQd1GSsadpQs7XYQp3mYlTBuVwtqrjZBa35p5jQlDpGyXeQl431pMfQFiRx8SL2ZOB7c3Lbog5dYmCZMP31KJpV2+KBBeZ8goaLEj8TuLAA5HCZ5mfnmfsrtBW2IM9puBKHJfHL1IYROI5P+kyUz4cmIt2dNmnO7wENTE0PyzEJ2vKJAWHwL5eJaYYqvDK7gpK9FdlVqHgn4bDC2zuYHK48kmlCjG1Wh3A0U3TFCrp6/bgSPpei/p6zv7lZtIft
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB2268DA0731B55F543EFDC78EA7D40@DM5PR02MB2268.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(36289512736943);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501300)(52105095)(10201501046)(93006095)(93004095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR02MB2268;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2268;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2268;4:40yuWae0APrAus8ZfCnNgFDb6xiqocVlLB0QzJ8rPYCRADy2qtuOBbtR2zNXvdS9yIZTeGTsxG+QtrvpU6uw9ioRG4ygbhkpQY0cthAQ/HIl30Ic6rDW/XBbI+YGrjrytVsoKvmsKSs91QX/TaO1Rh1SJsbt6o5cTuI4d/Xfy1pBXa6nH8ZoUsy8iPZHcIhfrgCABHlZPr+8f76WQ1JaIRMTPOCV6LXGw0Ou9aXwAnb1yHROc8x9I5O4A3LbPPxCOJFbjHJCUtbkDbLXoAduwYX5k6g3/8+h1WhyDrhfNYQuojirWySvJ9OsXqvM0QcGfFY46it3zqPViVTFtgVdjWvwAGLJ6AMJdh1FeUPRvE8=
X-Forefront-PRVS: 06167FAD59
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2268;23:pUCYwlGXgf5ebiFfRh8goTbQQ3o9JQFqkyLBQKc6/?=
 =?us-ascii?Q?+r7w9usUphUZTQGDmPWHEoM2m0R8h5+BGM1JWAMvT8/0e9FDFYwM/lOcd+oW?=
 =?us-ascii?Q?Y1Yi5TiI6gQ/DXyc7uT50GI/f/vbubUchvo32SngEquapC1hoWwM/dlogDq/?=
 =?us-ascii?Q?mdfe2kICap/qrvwMSe36PO4M8neyWVh5kFAvBWvB0pLbaQU+4SR36Hn3ArdH?=
 =?us-ascii?Q?uVwwSdGFveOhjLmpaWQxC5XVK3mXxyOGxgIiACdsnFA6cIi1wdc/4fqdVhVs?=
 =?us-ascii?Q?lGcj6bd19ZxE6lkvqFAcRALaVSpVB9umF9Hbr7aVc2QCaMe2RRRzWWZMy2/x?=
 =?us-ascii?Q?JsNf0JuMG+dnv4LWE5BrjNiUb2NqK6vXz8ZCbO2q1NkrCCPRZPWzzrwxeqC3?=
 =?us-ascii?Q?KakO05jewEu9OFhBmSeMWM+g+Nf5Q9IkYceQ6RD5ePbBTR/i4Elcvdsmn/fs?=
 =?us-ascii?Q?aO89fm8WspqrDYHsj2GqoJlOQ3eZ6gkulw67Za9F5DufQHAulhLDFQmNCYJx?=
 =?us-ascii?Q?+J6qMdmtzChunqFQE6b5SLm4zyiTLSB7Am3vog4FqnqA7tv7ppvCkqhhvPVa?=
 =?us-ascii?Q?8VzZmm31sfBZXBW9w8EA/t1+XZ8w5ARXumqKOt/65+zHv7x7vkUqMSSnU2fh?=
 =?us-ascii?Q?EohqwDJmtKGJNIGP6mrGWHiehlTn0Srp9n5m1FunnU+5tA1iJKrDeGPSf2qQ?=
 =?us-ascii?Q?AZ6fjoqc6EhZQHEmTxiWgYp3RcGNVWNOo+74LoMdfOni6Bwkme/NPFMdd7eG?=
 =?us-ascii?Q?QrLg4MgoCsht60DDW5Uhu2omOmcnhdh2JvGvD9CORfPzmnIj2fgehQeUrKe2?=
 =?us-ascii?Q?o7SMUZXLwRicWOCl0mxtc+0qx+sUems+V0cMnxztkkd9T/PTbvNnklWC8CDb?=
 =?us-ascii?Q?GBThxnQ+gYZ4rNCeedmni6RekSg9JL+uplKDI782/Sk5EWwgQugPWMqWg83q?=
 =?us-ascii?Q?4mLPhHUEwzJUxgYq+0K0ITn1s63YE4rStAJtQrk19WD+LPkO5Yeu3RLDyAi7?=
 =?us-ascii?Q?elkzbVGQhJGobCPUkqwQCJL++nItj8NCZSEDJ8uv8vhEbOwYn7Z87K6Ro1qM?=
 =?us-ascii?Q?dVVXYmGpN/3CYM+ESVT9Y77mWs0cbMglwBqserVLh9jwpR5ViM+Vq5kUfOhB?=
 =?us-ascii?Q?f7Z6UlJh2Wmde2MGH8/ScfNochueQJztA7h3/k+zM0x1b4FIDpEiMbvcbROH?=
 =?us-ascii?Q?NCkJahiPBTHDtY=3D?=
X-Microsoft-Antispam-Message-Info: 3Frtkuyr1GZOlKv56Cn0lkLHXEO51WNezLpzMtD/ofZ9yF934p8uz9W3D5UkN6gYrsrxbeW62Wp4G2CbAPN2Fcn150oR13DKTXygUnBemP+tTU5w8v6cCEpNYbiFrJwLsY2l9nojb6JBVqZQJA6uu+LIlkiXa4zdrvdcMuVtkm0lgduujU3aVgabEhdZKy/+
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2268;6:wIf6NdO+McZMkqSLDBBE49zkdAW9ujo/Syp5BLkO5cET6/9WPydcnHQ2u4WSCgQLnUJc6QaaBL8trPH3da7qOBgg07Gs5WKtdUgK033+oKr/eMMY3zi+y4uacJvB2ulIPY43djRFaFwcyYFnVQvZ2bcbEeIHocMf8swxMV4pfHL0U9NdTdviKscdxLngxCfh/fzATPlhrTuirGLOrTwoPPmiFrCku0QScqH7S4DomkoXuaP/P9okp05IG7Hs5lMd2s1Eg1Zde2wbt/wLmVAAxfdgEKQpxaGh3aVW6RaDE0K+NRgcF7fx4kNd2dcgvkJIXtCWkHFVw4jciuXC6gnBr4wNs5rW6BCml0Vl+CiYJN0=;5:dN6GNfjptck/Wlx/BzYUWQouPzMV7g6CJ7/6GxiYPmpj3Kj8K59hRpzAXihAqODQuI/1i418Owbj84rV+yOSlNAZ7VIrv5YrrWM7TgTwYQdUxRQhUZAFkhBpgKjrRhtbvohePn8HH6QPWKjuk7TR1I/6omfNWwARQUtvFXXo4/4=;24:9PwQY+N7vwUWnxhMBUj6rhpg/siAo2+OBp19YRjn4O73lCHE8HUGJVX5uNws0uVip8sWM8n0XBQqOB31Ny5u+Ja4y1FNp/8PXecjRW5t8g4=;7:Qo/Lq5//HTtDOQKZMfLpJt1fDzePDYCiJlSXo/P4CusnSo+qpkDwQi5GRVP7QV6y6w1OC0NUJUaLtuZkt9t5RA7ScfHgotj89S4w2IN25rGlIy4ucG+7S62PGY4j0dsfOuhKRUDxgqgH4MJPlIsqFVSQAYzElE+IWZo0gBbPr8LeMUZ45J5Sur6/po245fxPY/rGzR5M46+wvVPzZ9VJ5cGDoX67tM+HrGUkkxtW9mLKnDtS7DbscOhmIPTp/Jc5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 06:51:17.8171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6748be4d-e819-4f14-8949-08d58d65d116
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2268
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595347861307192100?=
X-GMAIL-MSGID: =?utf-8?q?1595347861307192100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes two issues

1. The code logic in dwc3_prepare_one_trb() incorrectly uses the address
and length given in req packet even for scattergather lists. This patch
correct's the code to use sg->address and sg->length when scattergather
lists are present.

2. The present code correctly fetches the req's which were not queued from
the started_list but fails to start from the sg where it previously stopped
queuing because of the unavailable TRB's. This patch correct's the code to
start queuing from the correct sg in sglist.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 drivers/usb/dwc3/core.h   |  4 ++++
 drivers/usb/dwc3/gadget.c | 42 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 860d2bc..2779e58 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -718,7 +718,9 @@ struct dwc3_hwparams {
  * @list: a list_head used for request queueing
  * @dep: struct dwc3_ep owning this request
  * @sg: pointer to first incomplete sg
+ * @sg_to_start: pointer to the sg which should be queued next
  * @num_pending_sgs: counter to pending sgs
+ * @num_queued_sgs: counter to the number of sgs which already got queued
  * @remaining: amount of data remaining
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
@@ -734,8 +736,10 @@ struct dwc3_request {
        struct list_head        list;
        struct dwc3_ep          *dep;
        struct scatterlist      *sg;
+       struct scatterlist      *sg_to_start;

        unsigned                num_pending_sgs;
+       unsigned int            num_queued_sgs;
        unsigned                remaining;
        u8                      epnum;
        struct dwc3_trb         *trb;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2bda4eb..1cffed5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -978,11 +978,20 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
                struct dwc3_request *req, unsigned chain, unsigned node)
 {
        struct dwc3_trb         *trb;
-       unsigned                length =3D req->request.length;
+       unsigned int            length;
+       dma_addr_t              dma;
        unsigned                stream_id =3D req->request.stream_id;
        unsigned                short_not_ok =3D req->request.short_not_ok;
        unsigned                no_interrupt =3D req->request.no_interrupt;
-       dma_addr_t              dma =3D req->request.dma;
+
+       if (req->request.num_sgs > 0) {
+               /* Use scattergather list address and length */
+               length =3D sg_dma_len(req->sg_to_start);
+               dma =3D sg_dma_address(req->sg_to_start);
+       } else {
+               length =3D req->request.length;
+               dma =3D req->request.dma;
+       }

        trb =3D &dep->trb_pool[dep->trb_enqueue];

@@ -1048,11 +1057,14 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
                struct dwc3_request *req)
 {
-       struct scatterlist *sg =3D req->sg;
+       struct scatterlist *sg =3D req->sg_to_start;
        struct scatterlist *s;
        int             i;

-       for_each_sg(sg, s, req->num_pending_sgs, i) {
+       unsigned int remaining =3D req->request.num_mapped_sgs
+               - req->num_queued_sgs;
+
+       for_each_sg(sg, s, remaining, i) {
                unsigned int length =3D req->request.length;
                unsigned int maxp =3D usb_endpoint_maxp(dep->endpoint.desc)=
;
                unsigned int rem =3D length % maxp;
@@ -1081,6 +1093,16 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *=
dep,
                        dwc3_prepare_one_trb(dep, req, chain, i);
                }

+               /* In the case where not able to queue trbs for all sgs in
+                * request because of trb not available, update sg_to_start
+                * to next sg from which we can start queing trbs once trbs
+                * availbale
+                */
+               if (chain)
+                       req->sg_to_start =3D sg_next(s);
+
+               req->num_queued_sgs++;
+
                if (!dwc3_calc_trbs_left(dep))
                        break;
        }
@@ -1171,6 +1193,8 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
                        return;

                req->sg                 =3D req->request.sg;
+               req->sg_to_start        =3D req->sg;
+               req->num_queued_sgs     =3D 0;
                req->num_pending_sgs    =3D req->request.num_mapped_sgs;

                if (req->num_pending_sgs > 0)
@@ -2327,8 +2351,14 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, =
struct dwc3_ep *dep,

                req->request.actual =3D length - req->remaining;

-               if ((req->request.actual < length) && req->num_pending_sgs)
-                       return __dwc3_gadget_kick_transfer(dep);
+               if (req->request.actual < length || req->num_pending_sgs) {
+                       /* There could be cases where the whole req can't b=
e
+                        * mapped into TRB's available. In that case, we ne=
ed
+                        * to kick transfer again if (req->num_pending_sgs =
> 0)
+                        */
+                       if (req->num_pending_sgs)
+                               return __dwc3_gadget_kick_transfer(dep);
+               }

                dwc3_gadget_giveback(dep, req, status);

--
2.1.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
