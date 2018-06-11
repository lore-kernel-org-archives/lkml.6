Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2ZZAMcBBHluedAAAmS7hNA
	; Mon, 11 Jun 2018 09:34:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 098F2608B8; Mon, 11 Jun 2018 09:34:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Omtf1BDi"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 99BF3608CA;
	Mon, 11 Jun 2018 09:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99BF3608CA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbeFKJeM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:34:12 -0400
Received: from mail-he1eur01on0077.outbound.protection.outlook.com ([104.47.0.77]:36365
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932109AbeFKJeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyz2aOwOnCZzyS4VcWDn5SicbMGLaXWPofJAFOTX060=;
 b=Omtf1BDiGBL/A0WPqsT/Oro0QZtiUseicyXUalv7AYPjYNwF6omP3U0zdXzD3tA8WKJlhaojunmh5J6r6Y1RQAyQH3SKQOb7AdNHNgKAO9qwFyGCQzyNzlEL59PcjlLNQ8/Z6p3yO1vUK3TXaRsmzeSB0XHFz0YEUaxlvzJZuJM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com;
Received: from idcbfarm.ap.freescale.net (14.142.187.166) by
 DB6PR0402MB2837.eurprd04.prod.outlook.com (2603:10a6:4:98::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Mon, 11 Jun 2018 09:34:00 +0000
From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To: linux-mtd@lists.infradead.org
Cc: boris.brezillon@bootlin.com, boris.brezillon@free-electrons.com,
        frieder.schrempf@exceet.de, computersforpeace@gmail.com,
        david.wolfe@nxp.com, han.xu@nxp.com, festevam@gmail.com,
        marek.vasut@gmail.com, prabhakar.kushwaha@nxp.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        NeilBrown <neil@brown.name>
Subject: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes
Date: Mon, 11 Jun 2018 15:02:39 +0530
Message-Id: <1528709559-19935-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To DB6PR0402MB2837.eurprd04.prod.outlook.com
 (2603:10a6:4:98::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2837;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2837;3:Vj6TG5Oso8ZiNoaFuo7Kk6vcE+ThScF5KzZUIV7nxvBjUSqB9DEjfcQilJux1ChI92tGS1PfpzJbUnMVw1L88nSAxK/d788IERAUqwP9IJD0bh/05hVQmBT8eXkaIvUE9DG3WvK8gxjVSgPr/mnb4zfRZo7cDUm6CMoBQpJXbtu+1ThmF5ZHxViiqQ+HFkygpTlX/6yRQzYrGplFX4fbKhOz9RpvQvMQcKFuRLZOTGMe46A5f90Odx/vkbefdzCN;25:IUM89vF+jF+PKhpG54xyM+xbH9bR1JmvGtCVvqRQCvbd168IE1nMiKdtrmGY5KKtm+hFiWiJFPumdJisJLJJtcv88B+FUrF8S8rzKzMCsSkROKXu3KhmmlTqC9SRhU7bcaQnf/4jz+pvyY/knQNOFgTLncts9NpsTHxJbdb/fbKDMFRCiV7A+KXKvsBcvHcVPeocdQHBoOrKFaoql82kkctqWUhjQ5OvgRKfHElOOwdYuAC9dFKPTcAY/esV2Bri7IZtFd0cmzn/bvTGY1wO9rCQKzdtB5NgVDt/Vet1WejY33VrNOfVvAl7PY+lsP6WRutN77MyBFABUyHt827+lw==;31:uZ0cGbFJ6iEUpynb6fq5NOdROa+foZGAAhTvcEcv+0feqUM3uNU8/0aTSBNmIdIq+2usDWVOmzJR0V3r+TgHmHUKqRWhqarNSD3ac0gsI7io/G/fI5ZOjSa9iVXBxILFqwSnU9hIYa4Def0EbdJTXZ1gtKEtjGI5EIGzXOFDvIFQz6imib4IGPnke0Y3ZB98OoFdvCGMeZs5xSGc0r6HTQKoDLuk5b9NDzaRe3NkE2M=
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2837:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2837;20:MV6iY1ucgH8h8Fjhx36gN/oPeJ4j0eoyLXn1UvhwbQ3YmhvvwxUXTqn44auBfTjyfOT6RcIm11qN/WIKZisZtj57QJw8ql6jEwD9LQX4HNmOZtTrRrWPAJHc2R8LsVc34Ac78pi3DM/ApR/i/f17idwROnKaPz5SyjDNx+azxpjZiYa61AT6nAOvhRyYfRfGWTjF2sbRb07Gu649AL8VAp9MWXiJQa7QFttrXHp3kPP5QutL6P/YZofIoYoA7IcWlKe5AJbPuAzw24NP5lkNJfju7Nj2QFYyTu+d7jssgeqG0NCieTqhPpvaz6BHvvJHoAwnMCImhoiscKL1jak1Gi4rX4KG1nZVePGEk38icak32ioZBcLp+OqMtK82kRP5zIPjkMo92Cqg//22WxdLvkcdOxxMX27yDz8My2WG2pHxmpNmpnfpDceW6/Zc4JEN+u2RpQ9ob18TlMAc+1qjwnYioKlwTvL3SKlWv6gQQjiuLWXE5kaACk0974s9/CIy;4:TAO8861dP+GXJ3GdBN9ChBfBWbxCWzYJhMIyP3/HUEIcmD02h0Z8ykZGtaj9AYMXrRzOGeEKnW1+6IZzZ6A7YuPYFaVVzEDV7Ar1mewJoBe4RF7OiZGdEtAjvnqRDd5cboM5REoKx/QOOOBSHwbYxGHQYzDjyXRUyMquSOMQkMJ6zbiCWiC9eX69A/R2lQysIaYe8fM9PuGMLrWvEmKf7z9Jpmggkqmi5QTXSESmRjhFSJpboNPeawedZW4F57ILlUMvTkVsjejBsziyf4KLmNV7hnHgkZJMODkkD0yHYZFpr1KOSZGn24WTPtyuuYjZXUQPmSQGDMhcyMxJOpgqdXUewE5hGxXFgz3q27PBwsc=
X-Microsoft-Antispam-PRVS: <DB6PR0402MB28377DFB9777C08D35ECC80E99780@DB6PR0402MB2837.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2837;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2837;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(366004)(346002)(396003)(199004)(189003)(36756003)(478600001)(2616005)(66066001)(486006)(476003)(25786009)(86362001)(6486002)(6306002)(6512007)(50226002)(2361001)(53936002)(105586002)(6666003)(6916009)(106356001)(8936002)(5660300001)(305945005)(1857600001)(6116002)(55236004)(2906002)(3846002)(7416002)(2351001)(50466002)(4326008)(956004)(48376002)(39060400002)(386003)(6506007)(7736002)(8676002)(26005)(52116002)(97736004)(16526019)(186003)(5009440100003)(316002)(81156014)(16586007)(51416003)(54906003)(81166006)(68736007)(47776003)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2837;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0402MB2837;23:234NkDWzewjZfgM6ENX1fMQ2u1CCLh4gcYsaNIU?=
 =?us-ascii?Q?E/prP7ARH2Fy5nGQdU26kJsRTmwQOvE/kEdG+qE422+pGxj5lshXCF9tcZKt?=
 =?us-ascii?Q?v59SJwMfSD1sLoZf7ePUfE2a8JlkujCnvn46BP666VCAIH4cg/aprBnAXGSg?=
 =?us-ascii?Q?48wC09HI4wHzo7wNZv9iNMI3qLD75y8qWdH1RymVFZHsBB6L8Z45WAv7Igxe?=
 =?us-ascii?Q?kuf5ILSRraD4g+x6cE3OA8owIj09weSxGNfkRy40QKLfpRXYF6qivKXgt+K+?=
 =?us-ascii?Q?t8TLnsWxLpcwZW34t4cs72DbfoIVt0M3Grz7cY/RQw2BOxq/9T62Yjl7rHm6?=
 =?us-ascii?Q?jI4xDR4bInDmYIZ4esiiKNYm8LfTHHZsAFZf8qVUpWWDATwOFp7XSZ2o9WhS?=
 =?us-ascii?Q?gqQoTEkSeg/O6P52uHgL7Bvi+cOC1QrFnu0mFb8eIHB70dTgmQEKJ7bRP5aK?=
 =?us-ascii?Q?5HKcjoCnM18z+zfgP/WTHnuy0/HtoEqi5bNRhtMQ0EppvRFG/YqHQofkRe2A?=
 =?us-ascii?Q?uBShkmXQKUewXJID1K1zzyY8L2TfZVId7KuaklTbUjoiUxsVFWOvZjbKtCD0?=
 =?us-ascii?Q?2lRU5and3q4DwltYiKkeKg4hIEpGg7NsV+iuMx611Xt7zUeP5I9pSAajt4xC?=
 =?us-ascii?Q?inVk8WjqEj59hVoyXFmwcc2E+kQom+SlFdzV62QV/y+Q8qZ6TOLTDi6SeJLQ?=
 =?us-ascii?Q?IonnCOTCxmbqCh7xxEgUHybvtmyGJhC62Dxk2ayhNzau3Yr3aDdJEtGVoC7H?=
 =?us-ascii?Q?tLn7cr2jzE46ZUm0Y19omuMawi+6mf/3gJY1qErXMtnAy8ZSYb6/B6J4n5lj?=
 =?us-ascii?Q?KMvN8K3fRk5ybH+lNGUY3bjEl3qN5W3R1F3tunk3SoArv/fn02xwEhUykNW7?=
 =?us-ascii?Q?bJ9Sg1SwBP0Ym6CWsIKN2Jfy/K1TtY+z3pY57v8lbDTv6m9yKTvDIMDlwoL9?=
 =?us-ascii?Q?WZ7T2G5aulzHJBenb4ec1ocVnYkI38oRi14at3wcNhNXIYvbiGICu395fEm9?=
 =?us-ascii?Q?eRf0tS/9thiMqqVM5rTcM8e135xq239iAmSB5gq+vu4dMV2yiu5+hTjS+JTb?=
 =?us-ascii?Q?cKZKBDZoYUIiFa7G6ItcJ1J+Bewb1lsiQmNUEu+ucaM0yEXD7HmR0JNVhrbU?=
 =?us-ascii?Q?RGbDjRdPIKjCQMtjgmYCjT8tpCpBkXg1cjVHa6jMvhEILmPGPQ/KG1CyEq8j?=
 =?us-ascii?Q?beKH0KZZJF5hVbVgpt7BErz+WEMcWSIOyiJdX3HxSw9p8YkwRfKuy/6lJJOR?=
 =?us-ascii?Q?8m54xKHGAhaHMpXe3hRi23k6yeKZaI3rvZ3HDV3DbhG5hQU2e/dZ2ZzCx8yb?=
 =?us-ascii?Q?2ddEYfnEnVi9qv2RX3Wcx3brsx5XxrLUZum1yx8Ib6pZfLK4aMt8SDQX7iPW?=
 =?us-ascii?Q?V5Zpstg=3D=3D?=
X-Microsoft-Antispam-Message-Info: jWtTGfbu4Og/2FQVQ8T769881XTGHwpdyXQ3QiuOQ2fIIm5ghVDD/i00p/6p3MayQ0ZlAeEvx/TsVGndrZ1xM0CSrstNGyE0LUeEi96WNcVXxov705AnJKCjJ9uxPL+8/vdl0eiS8266NQtGAcWjZLAyPj48QERREBXGOQQxuXbdWb1l1nrJ71knOmcfoRAF
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2837;6:PyyY1PxiLBOYTT807tprSpyV9bt7B21amoQL/sP1QVzKlKnlQ6IAQNotEF5BG1kf1cVXMNDBUCK7kJWAZ+EDfm1cxEE4Ue+sohM/FSsatLraIIxik3W7yMhhIvTmYo0NjtHPuK2C9yHAnGykBG2SDS8SXIznO55ROE8ulDZYzoxUTu7GyRT2ZunexKFfUV90DAeSXHRE0DVaOa91QW9Ee+6jIhsBITkmD1vRlqHOy+8fJbCIV8Gzl1SsnicoPFCMSCh7F+xoEM64GiP2LVefuUxRCrUbdPbZAa+4uHc7UiNQs/N+RZXettOv9qOFaLsahk3Pwt01e4PBC+EbhnalgOPWqQ9XryzAdB1c9LXW3igVQNof+VF4bj0Egsc0hz6ybm7oLmduQH7ez/uobBVLry9I1roN9qsxaV2mUZ2JMzoED8kzHL72j6QxAoH05RfemjX/g3kgXcXw+XwuQ78b6w==;5:tdUj/DTuepiEwA/vfziWXk0Nz8ZNnVdlcrZfej09dU9roV24UCp3cn1+NT7D1iawXUJawgr0y+o0RTuirtxZzHRO83oaBP8krP1aIJA9BcgCEH5bXfscvHQpZo3Mxz0Czi7sW0BI7bTz4kpH5JxcYZhMMuVUcP9JfZ9G7JiHoik=;24:fXdXSV7nLBfWwgiaBiMoyBO8WLiEMJKsjyfqxD/YBKe3mcicrlXzMc6gsmuFxzbrVZFg1VjxxHRD52wKQ7d3ReFwJQ/GBEDbzkV6DnlGN7Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2837;7:zRqnQevQ8wtDuSSO2mOS/OsI+HsyJm1eT4xVzi8q1CJvFXRGgb44OhP8fk3p+hD2ZDI7ZwdGgzbo4WHVyB/XlkfSXSnFUXZOX1CO84hKd485i3MwWF1IFN2rhkgK27LdzeZmpp1btoit9yEOZ1DmMW+r7dwi+zN4qwIB7nIXmSA9pt9Tm26ClxpUXbUOg8v6kBVrZkT8mSOwKMb0eq2dUg3obdaaMgV0YAjGthMikVdOLCFukRTlNxmlmvIoI6NP
X-MS-Office365-Filtering-Correlation-Id: 706d4a6c-9739-4b25-1ceb-08d5cf7e7971
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 09:34:00.9796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 706d4a6c-9739-4b25-1ceb-08d5cf7e7971
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honour max_data_size for spi-nor writes
In new spi-mem framework, data size to be written is being calculated
using spi_mem_adjust_op_size().
This can return value less than nor->page_size.

Add check value of data size return from API spi_mem_adjust_op_size()
with the actual requested data size and write, max, only supported
data size.

Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/devices/m25p80.c  | 23 ++++++++---------------
 drivers/mtd/spi-nor/spi-nor.c |  7 -------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index e84563d..60224fe 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -72,7 +72,6 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
 				   SPI_MEM_OP_DUMMY(0, 1),
 				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
-	size_t remaining = len;
 	int ret;
 
 	/* get transfer protocols. */
@@ -84,22 +83,16 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		op.addr.nbytes = 0;
 
-	while (remaining) {
-		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
-		ret = spi_mem_adjust_op_size(flash->spimem, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_mem_exec_op(flash->spimem, &op);
-		if (ret)
-			return ret;
+	ret = spi_mem_adjust_op_size(flash->spimem, &op);
+	if (ret)
+		return ret;
+	op.data.nbytes = len < op.data.nbytes ? len : op.data.nbytes;
 
-		op.addr.val += op.data.nbytes;
-		remaining -= op.data.nbytes;
-		op.data.buf.out += op.data.nbytes;
-	}
+	ret = spi_mem_exec_op(flash->spimem, &op);
+	if (ret)
+		return ret;
 
-	return len;
+	return op.data.nbytes;
 }
 
 /*
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5bfa36e..3e63543 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1431,13 +1431,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			goto write_err;
 		*retlen += written;
 		i += written;
-		if (written != page_remain) {
-			dev_err(nor->dev,
-				"While writing %zu bytes written %zd bytes\n",
-				page_remain, written);
-			ret = -EIO;
-			goto write_err;
-		}
 	}
 
 write_err:
-- 
2.7.4

Patch is based on the spi-mem framework[1]
[1]https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-4.18
