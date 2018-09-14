Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A024ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAEE20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ttpY+eSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAEE20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeIODtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 23:49:00 -0400
Received: from mail-sn1nam01on0049.outbound.protection.outlook.com ([104.47.32.49]:37216
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbeIODs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 23:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjV3sLGrDIyXaqqrrV8lczttNGVu1pnLm5C4sO5VBa8=;
 b=ttpY+eSjFzAki2PmLE19G7JisVfjHLgxGS9R4efGzD5CYE6dFUWVjjY8exLfaPjOXDCzJlxD045yxs66jiWHhNAwoqABKykYno9jCmAIfADX+KPrF01C/H3PojEwkt+p/GlEyKpq1MBFSaEXELNhzUoBDMl+MeThOAsKrzqYjfs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
Received: from gi-joe.amd.com (165.204.77.1) by
 BYAPR12MB2725.namprd12.prod.outlook.com (2603:10b6:a03:61::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Fri, 14 Sep 2018 22:32:29 +0000
From:   Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Dan Carpenter <Dan.Carpenter@oracle.com>
Subject: [PATCH 1/2] Fix static checker warning
Date:   Fri, 14 Sep 2018 17:32:03 -0500
Message-Id: <31c49295223e51f5c1c4e36e7a09fe100dab1711.1536959537.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1536959537.git.Janakarajan.Natarajan@amd.com>
References: <cover.1536959537.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR0101CA0021.prod.exchangelabs.com
 (2603:10b6:910:3c::34) To BYAPR12MB2725.namprd12.prod.outlook.com
 (2603:10b6:a03:61::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 001af795-8b6d-4d8b-65f5-08d61a91f4fa
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2725;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;3:biu2+Q+PdOuMMthHIwR9rgO0/g4JolzGwI0Hng7Ctd+hfBm0hbshY14gSFker/XwfWiRohGVM6XBpTmqXmiUa1znx6dNleexyg1dtiwJWv64i5xmOGatPB5+4DRUIE6I3zJ2T2zxufIkndbnXb1oEZjRP9RPkzAHItxcuiqzhgJTNMzM2dbQUBi0qpFe8mQodpkpFUQ+78ovgkXGNXklHB1H4UI5DBuF2b131Q3daEkpJNFi/bK1M3qVKvl10GLs;25:M60zr4J6E8jjqNtW16W6nGLmagpckQB1kRKVyBew++jxTUeoSZjJHaxkTSUJGQMRH13PrWjSBuMIlabHm2QSTVuMXGXiAwsFgNaYkpq22WLXTYZc3zTXHxbQ0ztC0wwLn4hZsWtL0CfK7WGBHHDjWFNHDy0aL615E5lpd8P/9tDvU2BkkpIlQ1HxVme1b6s1g/sWqCS3QTTYjETevgiL+3bUalb+naB9vfvlzmE+sWQKl7VNRZXSiTy6Ur3oz5h4qCOhkU/2KjydJOqeDJ91rFJqp5lWcp7h/qL9oXtD2iK4QnfdaDUklUeBBFH19up31qR2QxzHBcNCD3VCUWRNOQ==;31:FOC13+LKmJ/1JuABnGzHcdAdZhAe/Nh/lC5bfnmLUaUJYXU5DUXspG5dGrMUuenkcV/AH5Xcvps+nVPa3OtxCwITxeGaqjuHccv26XkrWNHyGJUCa9gQ3rNOcijP+R7vuQeFkqpSdgXBPpmkUzxmvUryQZxAfeZ6exStnnXUaXwTJkoonNjcuvzk0Q/xw48PXeCL4Ez/YBaBWEXQg987bLvcBIlc9t1oXlKI3Kf4izM=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2725:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;20:aUY8TUBvo8Qsy51+pKIUCf9oiAwOgji9HsoHxIbLxLViW2seIYY0StZ7vGmkSn81y/PwPCr5PmsDtRDjFgQasYBF8wVvGjCFmXBZewDln4slEiLsiXo0dEHYY66qjjIfOPzozIJ1TPRXWgeep2dK7eT+l/cs/jCuxsmGRWSQ9atd6p9bNMiqdLrCWM9xbxl+F3LTEBMldi/KHycOeL2AnSdUJziu1MbpRkYU86HSBsGd2AflSY37QyaGTUk6Y5XxYLvGVN0Au/sjJDCSZMNfXsLUlGKcvb3Puu7vGiiijNNrP40hLf9lpWtYiVXmUTXQ2gCEvZlYAxT4FzdPV9zYhLmvLZfTLktpLO3XgSB37oUmkQNtDsgAuTnDEWgv/IKgLM8xLZ33b/f2sq8Z6e0CtcF3fxe067ZaHBQUOMfIX8HaLSeBCaqNxx7rG+n7deiwlsPRTCb3TFBvFKxzvfXLD/HxL4ZTchOVa8mM4Zx8LrLT0d2Yit68YFhApvBe9vnD;4:nC+FlL4O1+6H5nLAKDC3pFI96dQKEdScQfGpd/hGyczXfM/KmN6noVXbpvggsmzMn8FxJVv8EsscRL8/RpZV3MEtFMDSYKhUpZ4G24Y66tNlCwTz2o/MERM+axktWTrOchbRNJlcecFuxPrpzrLC7Wp2r7XqH99Gz3waQoBv9xZB+q9w+ENEwL7geJ2nRUjeQC37aoUdnujIKx2IY4mgpb8rw4owZvf9MBXvtW6kYlF9qsF+3FKJKLXcTzpoWSTOw9PjCRBgeRoCvuYnrm6dgapsYPF2IxaZgPMzqoYMooJZ6hJJDJphdKcaql0yIhxHNw4xxey13fI3pIgZSzp2KiA5JYzMh88EojcOW2/t2wU=
X-Microsoft-Antispam-PRVS: <BYAPR12MB2725F46D5D60B72542FE330CE7190@BYAPR12MB2725.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231348)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR12MB2725;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2725;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(6116002)(11346002)(6666003)(3846002)(305945005)(14444005)(72206003)(52116002)(26005)(7696005)(316002)(16586007)(7736002)(54906003)(5660300001)(105586002)(486006)(446003)(53416004)(106356001)(476003)(2616005)(118296001)(956004)(6486002)(4326008)(50466002)(48376002)(47776003)(66066001)(81156014)(81166006)(76176011)(386003)(97736004)(186003)(2906002)(86362001)(16526019)(25786009)(53936002)(51416003)(68736007)(8936002)(50226002)(478600001)(8676002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2725;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR12MB2725;23:w2n6m8Cy0X2WQXP43cZGVdPF6Frj88NNTZXZ/fvu8?=
 =?us-ascii?Q?D4eiEY/8+piBlOAsleZjkIrRKOCFo9gfP9ElxwlNOxu82/pFRm9WeTLwAusz?=
 =?us-ascii?Q?fK9kBG3QrOdodhOLE06tUJjTy2txhJS5AihY48WPam/xj0wNmqOEexxPbgyz?=
 =?us-ascii?Q?W4sDGmP14KRmdniIuEdQrxF9zstp6NfXTuy9ijx3KHk6SsihWki/LzySrHF8?=
 =?us-ascii?Q?0HtYPiDjL2DMTIKl6kz6wAe01rDP8OwxnJFCady/kkAr4/c3c4WrKJdyr4H1?=
 =?us-ascii?Q?8gVJkPwjNNNReS95P/LdOIRVVwPr7HwZSe+Pv9uGaSi0mwzvke74sBYclusX?=
 =?us-ascii?Q?yYA4e8wI7llNz+PCA8tZX7L4/1cWf6IjMEcPNtztby8wqqt+X/D7XHT+ohgJ?=
 =?us-ascii?Q?Hi+Y7Sq1NC9IyddTqE0iyPwCZt1235y1fCz4UWGxmbYb6p9wiY3nIAMnpk6w?=
 =?us-ascii?Q?xUAGCcrYf+BZVsSdWBV3D0MlMthDhd5FOWheAS2EkStsxCiwNsPexT4ohE68?=
 =?us-ascii?Q?nUXrHByPMyTPzMBu8p8KBbG9/TVJQb6P0ngNV1PZ3cziSYJkFqXIhR8Fo/tv?=
 =?us-ascii?Q?BSWEbMIu62PiXzk8wQDsIcuoCObSWEg6s7N1qFVL0b32cY73/1xeCCcWZs5w?=
 =?us-ascii?Q?XmaMZu03F5FYOedsc8f/Ohkz956nAk8HH5YIfZF0zA0Y8UqkLFyQnAJM2Yz6?=
 =?us-ascii?Q?n4Yk8q6S6CHBvhJ27b7zleMUsRgWe50a0cYy8Fv47bh6Row/bb1ClzHtLH27?=
 =?us-ascii?Q?yRg+Bu5xzCK2f2BTGqLM/h+3Yb2WwFUNKAglycwHz2dFgPAxYDBFHCuutYYs?=
 =?us-ascii?Q?TuVtnDPTF/jn05DJNuqRTXVpKWrB2B9PHHY4WMkIjmnY1sN7f0qmEfA/j8/S?=
 =?us-ascii?Q?f6QhRuKINp1JRdQqlyTJBjPb7jZ+LjvntdTarx20vkylJjuZhfObY91mJikA?=
 =?us-ascii?Q?9yfaI+/lN6KiAqjOzlevQByb0Uy9fjwFwYDuFVWATz5b+lrvBkce5SPVL33y?=
 =?us-ascii?Q?U677zY6eghh5tHmgv6TU2c1SpWt4a2GcqvMx8gvJyl9vbTCEdWqCvUUGrAS9?=
 =?us-ascii?Q?dwRwSTHVQPb7Y19xmNHdwmZzNpAyduWzTPzd4wqzkfUf7mZK07O2hZOoudVS?=
 =?us-ascii?Q?c42usfpGAuWv/QSQiS/G8NtQkhnXT/TX6aNOdl9cFOe1+DAEXKf8n3tRRub5?=
 =?us-ascii?Q?vX0qb1M3F8a0n6xcOfDK95c2cw6TguSN5gh1vTWyF0YIQFcvSJ3yUa5UQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: WQd709ZmucXfJg5fWWI0doBrapsIR/ilnWhm5hPQf4KGNg7SBtYbq5nZhoEawiEkC8yMC6dlmKGv3Hp6pUP2evUcBwgq0oxw28RwmuzQ1GfkL7KzEMtzD/3vAKTeUOcBk06RoA1xCeeXPK6tPDZpdutwRJ8t3H9+VAHf1b5o5Ag1KQgMERaH9tbdvpHQ7TenqeMg5F8PzVC31MIL0Gi1RHFlibSiHhLlRs8DG30Ohe5G2a54F5ZOhZCDQfdfWJl4UFV444/ovYPbd8kWfytc44nJ5MMI4BT9SmgX43/zcRR1ytKpz0ZZLFucddUGqGvfpMjfO4hW8QuK7R3q3NOql2OcEmW11v7gGh2wWJl5ChE=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;6:9ME9GXwTZGgFS9Ef2K6YDndiVL5SangjsxdtHdB5xnj+bj6WBQ3jEazHABJWwuZjJNyNHHttOvIPsZ5GAkU+5RqTDnFVOlmYHmL4sYG04tzdJg/2uHDpppXKbkkZg5tR0dmxh+nD7VT9ZvyeQGfw65UMgrVI0ljxQAEypC8dUwBRyyVE+4CsSkagEVwtzWd6BQ1UMk/GBXeOFZw2SCgSf/r2guJIL+pJh4vgKIxYPZUW3d9RtM09PzoBeDBMU7rFY2QZ7O4IjQ8EkC8fuD0FYne8GQs0sS52U7sf7puZIAoCfe58KrRE3VMa5rvIFMGbGh9WO0ENgu+MsteatGnvdc0/1+ne0pRA+pmu341uvX/C8sN641V40upjn/ecmZpNgAkG9ZYBizCeUFmuN2w5J2bpCwzi/KJ/vpvMJowRStrLTvSQWqCpReL0F+HOgeVd19CB48e88ywk1fTHEh0iXw==;5:CmSVz6lYbX8CT0XZxzw1bzyfouembC3Y30yg9M+YDiHiL0Plesc6R/iB1uSkFQh3kxI5ZB8bSUPsqw9+3K87kn1eFS1Il5YfVGMLumioK8nB2UQ+lYw2bKZrUPovTfcEjZoRahMiyr4k8JFvPIPnzasX2Y/kckORvQpjgMU/hPU=;7:vsgjbeJqOrTUb/rj8qFbBLzUg3oik2pJhk5XWd+xuz/d8x894xtKuDXX6evOprG/jvik4BcEcU4u3AzJ1z+IHjui9QkDXtuYukvrQIrPXtbAJ8+fywhlm7iedM4M2tw85NtUhyY5G1eEL0OuxggcBdABK7PFg5NMFPLKTX2pJrGs9XI2P61CMYKKa3rvezEtLim2gYnyKxsqiAXPWhrTFcmhUHt5S7K6ggNcb1H83hd3Fqu6TY1UeGxRzsl4MRTs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;20:r2OAWR3cqRT/45OCtcr3JJ32wGks0JXPIGjJxBq1Yjcj6n+HUtGo9rj/aCH62xYFW5Yn75cLrDfYoS+axN+ljk6ga3WzY9lmXahMFl6McJyV5YdUp2gjL9aM2Rde7y3xj6TwDnMh+lPgBbsx4AlluAUM2o9P8gbthhX4j5DWAI1aDU17UXC8+bIjRn7sWNFlw8Edsx/ReAlPPMtqXIOPbuy/4RMcOT09ck84IzLClPcqGnXfI+VLHOW8VL8NJ79T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 22:32:29.4299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 001af795-8b6d-4d8b-65f5-08d61a91f4fa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under certain configuration SEV functions can be defined as no-op.
In such a case error can be uninitialized.

Initialize the variable to 0.

Cc: Dan Carpenter <Dan.Carpenter@oracle.com>
Reported-by: Dan Carpenter <Dan.Carpenter@oracle.com>
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 72790d8..f541e60 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -423,7 +423,7 @@ EXPORT_SYMBOL_GPL(psp_copy_user_blob);
 static int sev_get_api_version(void)
 {
 	struct sev_user_data_status *status;
-	int error, ret;
+	int error = 0, ret;
 
 	status = &psp_master->status_cmd_buf;
 	ret = sev_platform_status(status, &error);
-- 
2.7.4

