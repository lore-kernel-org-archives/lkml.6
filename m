Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F3EC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715C42064E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Xqpfg2/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715C42064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeI2Or0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:47:26 -0400
Received: from mail-by2nam01on0074.outbound.protection.outlook.com ([104.47.34.74]:13984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727535AbeI2OrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl32i1G58xiiVTE9JOYlOZzC7r2825FidIjbehlgUq0=;
 b=Xqpfg2/xiOQ3YaQqa6LcTUfX1MZ4qBoDRMc9PszeON7FvlaKcNHfqYiajy1N33/E40gIHEPgMySVETriO78QkRM7N7H0Ud1c+tluY18AT7vz3zMTQyFKzfNberoyGVI/cC7EZLTlL0DP/BrFc3/p4kbsrr5Qyc8MF+Cik/QJhIs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
Received: from hyd1621.caveonetworks.com (115.113.156.2) by
 BN7PR07MB4610.namprd07.prod.outlook.com (2603:10b6:406:f2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Sat, 29 Sep 2018 08:19:50 +0000
From:   Srikanth Jampala <Jampala.Srikanth@cavium.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgadam@cavium.com, Jampala.Srikanth@cavium.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH cryptodev-2.6 1/4] crypto: cavium/nitrox - fix warnings while printing atomic64_t types
Date:   Sat, 29 Sep 2018 13:49:07 +0530
Message-Id: <20180929081910.17652-1-Jampala.Srikanth@cavium.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [115.113.156.2]
X-ClientProxiedBy: PN1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::34) To BN7PR07MB4610.namprd07.prod.outlook.com
 (2603:10b6:406:f2::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09692e74-3d85-4447-a145-08d625e45490
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4610;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;3:cGpggqRerZRNKz+6fXqqVg/VSUKfwR5P7ju0xUPy/gmsTG1/KWNsBUQXEKdiAgAlA4jjpJXw+5KQK7oUIrJAkh+WsaPZXIEXgD8p0v3L72DG7HcaYHDLQNHh4EEBlG6oVFj/C1fkyAB8xt9q3kr6vs/DvkhTimuGrZmwIyveM1Eosq8ZU5XqxSTwZhVM4BitXPB9zffSIdBJRfhEHjBoOzX2F8YKcbDaEe/oc6hHhJnpAX1VmWB2GJWCHqpQd1yU;25:AVup+yj1iP21hoqOYWmlDGsXFINDQIa6UIlXY4R53N5xiCGteugnh81/21WoE0EIUhn85vJjRFwdGvEEXY/X7l6yfYQ+IzPSb9Dw4+K88Ja3GMNkRod5h/7Clpy+FQGMbJW3w5sWgy3TQxieh8gkayRB/J3j2/3fIigeqCjQAjMrBB2mNJZ3E6uZJaxkWbocWoO4ucvz6EEApfIxQ1A0w0NikjHMJRntylMTszsDDlxjBDJKiZpBc1ezgl3Euydp00mpkBi9AMLCqPhepiPDcE1Q4suYsYUvXoaCYG93eCCXVH5LWTxiLgiBLLg9b94X93QcE2gFGRKOv2K9Q/QD/A==;31:uN2WpUumedUOXq4RqlftFEKOcmxZ471hoF8Zsa5WhedSr9+/HzSqaLKfTDdFr9kDtOn9i2ZjdvHFZpWBS7bDfqRoVCbole5y6TFpwiEzsEHJr0uM5DzhA04iVX+ktxRoXt1aq1JO8Ma31nSgHmpafUYanuxc9li9m8xXiI8Jvo1ZAaeBZX95sESFisuWUZBhwgOpDw+xmGO/uqKo4NB7GU+uYG6RhAXqckQb/kjeFwU=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4610:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;20:vow5s8leQw+XIRy8LeOihHHZ9ykpzfVUM4GwkEUntLNlH/3OI9mxeanf9X/2gDGUQB2x3mcvEouMzvjOS3MINg58w4XV/W1nwMuDwZmWRlNdAB4jMAra5ViPjMmVJZo//VA16fKPx165m5DnNzpoOKkluFJr7TFRWnv+LJzae5y4BqJM2tDJiDYkmPzZqAcT07R9jJkFYkLePtbhuSqQ275CkKuEbCBCKYBlQKKDIaZNrX61iCeOMoPmrVP+H4hqSLLrQBCwldvhZcOvNh4Rl8nMzV62JOT9Zl7Jks+X22Lh6EBUBVJoCLL/SXdZtosJBc6ARgt0YvPoZNlEzzW1eVlSnaOMTdY9qn1sCgHipyuvZHlAeMUHF5PuLZF+0qGn1yfhb5Hi5JHI6ct1QyIGGlSx5VTRy5siArcRpQZqp1ZfC2PeUJEztkXb0KR4bPB5FnZWiXlFkaiJSdz2SXq8eNvNOlFigyKkBD+4VKs6oNeuhQVVToM7F6Oj9Cq136Nx;4:cuqPWJawox5zDnc/PIhmbwZeeBPJfg/VCaPDKJPFJ2m3GATgkFGXfTVclGGoVs9CguQqE+ThiM/ASrJJvKKIJ2ao/zZsZ3fpIrt/7C2H3NHY/D5JERb5wGBYYWOyOYqlRfqz0jlw5Ed8xYPG3mCiKbSbspqLruJQAGfiZh8AslEQL0UK6MwCuKXXni71YEKwxcoqEN5MJwM+4OUBLkIdSWJeszGFK1EpT3BkbkhhJgSsJSlXF5bE5e7erhVkp//vBTAUktSC4GjDs3t/2R47VQ==
X-Microsoft-Antispam-PRVS: <BN7PR07MB4610E35107D072E24E772912F4ED0@BN7PR07MB4610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BN7PR07MB4610;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4610;
X-Forefront-PRVS: 0810818DA0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(7736002)(2870700001)(69596002)(34290500001)(956004)(386003)(53936002)(50466002)(81166006)(105586002)(81156014)(2616005)(68736007)(52116002)(186003)(6506007)(6512007)(50226002)(106356001)(8936002)(16526019)(26005)(53416004)(86362001)(5660300001)(316002)(6486002)(25786009)(23676004)(478600001)(72206003)(3846002)(8676002)(66066001)(6116002)(6666003)(47776003)(2906002)(476003)(1076002)(36756003)(97736004)(305945005)(486006)(4326008)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4610;H:hyd1621.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjA3TUI0NjEwOzIzOkdreU5BQU9oSTVseTd2Z3RLeU84MjQ5eXRE?=
 =?utf-8?B?OHZEN2NmSkdDSDhYazhUK1drZUcxRm4vbmh2bzh1NVhTVlVWTEpqaE51OEF1?=
 =?utf-8?B?SlVzSVBXaUxKT0E3c2E3ZmIzRXlQSHFQNXYwckVxWkcwQUVselI5azAwcjRh?=
 =?utf-8?B?S3AramxBdWlwTlhsTG5RNE04aEUrUkdwVlFJbFVTbEZTeDJPck1LQjcvV2dW?=
 =?utf-8?B?ZFFYMzk1ZjJCS0J3QzEwTUdDQVFJd0RqRGY3ODJGVUh4NGZMM2tJM3lyMEdY?=
 =?utf-8?B?YU9jZE5XYStrRzhsR2tTQTF0ZUtickhUbHM1Q0Y1K0FhOUZaVTJyQ0E5M1JT?=
 =?utf-8?B?Y2xhYzZrYnp4SFFkK1psYVJ3aUVIVmNpc20zZytiemFLcWQ3cW5iOGEvMmc3?=
 =?utf-8?B?TkdWdG83ZXNwdWhqRjNtTjlZTjdjV0ZQcGtjdXRGV0h0cWlpZE5aSWZmS1JP?=
 =?utf-8?B?TGEyemE0dDArQk81QVc1dGtmMCtXNm5nZ2ZGK1ZlZGJJOGYrUzMxdXpwS0pH?=
 =?utf-8?B?Zkl2UmoybHYzbFlpSTFSdDhsa29HOTQ1ZmM4WkdISCtHRllNcGlBZXUxNFhG?=
 =?utf-8?B?T2RPdFJQMTBrNWdacDlYK0RIdXo4YmtKc2lSdUxpUVRFdWVBd3JTc25FTVZI?=
 =?utf-8?B?VTR6M25qcWU5eEV4bTQ5Ti8vbU00V1hlVjV6UGp0Wi9WcDhVeUxZZE9LbmRF?=
 =?utf-8?B?N2pmQnBXSlQycDZwL3FmbUM4R2o3WXY1REthVnVmUVB6U2tCOEtFUnpJZlRw?=
 =?utf-8?B?NXBkZFVRZFdVY1FONTVlMlNJeVhXZ21qS3NXdldQV2NiY2xBVFdXMDUxbXpO?=
 =?utf-8?B?TFRnNFhKTmFSc00rK2lwTEV4c05JaTQzeEg3Z0wzUlFuRWpOOWJ5ZGdWWG5Y?=
 =?utf-8?B?Y0UrdG4ybGh0dEtsTEc5WVI4VXpUZnhURlpHLy91WXBBeEV2enBxUW8vSkcv?=
 =?utf-8?B?Q3VmaXByeGlCOExtTldXdzZtZUxMdmFtTzRrNGJjWDZIQmROdU4zNDVCVmRm?=
 =?utf-8?B?d0J4ZE5RV3dBWnIzcmx1ZUxpUnVjNWN5a0UyZzJ0Mm1XZGtmWUNJOU9EMnFW?=
 =?utf-8?B?QTErQjBacjJkT1ZVQ2J5ZkpUY05SYjJ6WENsZGNRTDAzMWk1bGRPdVk0eEdE?=
 =?utf-8?B?ZHBURklISkY4enhjaE5OdDNGSERoZUJUeCtrcHE4dHdFenZzV1NOZ1c4SGhm?=
 =?utf-8?B?MHQ3T0VQcEhQbmgydklIZ1g3Nkt4d2M1VU1mZk1Pb2xNdEZlMnYrNDJ1K1Zr?=
 =?utf-8?B?Q2FKQXA4ZXJqaUhYcDVhUU9sQTZyRUdIcEZIL3A1Qk9IWGVZYWZpRnBOOU0v?=
 =?utf-8?B?eUlDQ0tyYy81dTc0YUVUOGp3RmFBWHNlZ1dTLytXVU5GVTNMM3pld1JiMm1z?=
 =?utf-8?B?SmY5YXRJdjNPVlNtZEZDZmxPQnZENTdQOHoxdXlOWG5XQ0pOZXZxWXhCenhw?=
 =?utf-8?B?ek1LU3dEamd0SzQ0RTV1VjVVSkFGZkFyeWhHTVBpZEZTbUpESnlFTVNmWDVH?=
 =?utf-8?B?ZDlxMkRBQ2U2eVhFN0xibGhSejd5VVN4cGlLSzJybHVQVXAvVGpTclVwdVZn?=
 =?utf-8?B?QjVCUThZL1dKMVg4UVV3T2ZlMC93bTUxUktJRmF4TTQ0K1k4dkJPL28vcVVE?=
 =?utf-8?Q?sMKIn1qgkac/nRvL1Cs+?=
X-Microsoft-Antispam-Message-Info: QtdS7Zx+PuKmPuutXgrJQ4OpVbQtIRPP/UeUpQChx45oJgSP3c4CTMWf2ca+T0+/1YH8onB2FpbK164lK29Lazd/wZtzZMOnkiya52URnZzIKOCPzwI6OMuRwkX+SNkWIZzPQG0SmMpymOe+tK5W6WvShk9h/+arUWIOxTFZRZnjIOXnpdMS0jyRqvXICMQSxb1YRstKzSOcih/FlVLYhnZM9FGXAguCIcE/l3YyC99QBOKhL34gUTqLLkoTEzULzbd/sAkUbH0y4CPAfXCz/UkhJ24rPqxlVTt96uVqbgwkFmSvHFw6TExKYk7V2+cE4KRwUoB63PaK35sxtZhLc2qC6POm1wbb4V8JB1c5HGo=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;6:6e/ucHx4rKAL9MIJmBJhrXaSgtcRPRQ9EvVlm6JvOIaUVu1i9c1zm3KmPfMz65GVxlKcAIgLsKc5lJpJMuhaulQxG/cnCgRyIuMDVPjYi6Nykiwp9/ItNWRB/wMPOmWnaNkR5k3Nl0NEW51tueUYmrXTV2wGgkZLpEXam4vRMjN0G8UJw6JWa5r2ElIvwTUEBqiDnCDs4RfOsJe3l+I5x7crqsy9oC0V8n50u+2NEZ+oPf//5XPk3FS6mVhY4/jc7CJjucoEMEITNjcUC1nQYVm84oYCxxsuXI8T0N2Vc7KIu7p1jcep1AodcivhTzsVEgBMliiTTf0QL8yRusnL5j53/d2/WBmWPY9ow1DpxJ0bl6UxtEcylvbMHOOtKttkvcxQvqKS3ayfUBLV/alQVwVlQ08gGINHRdJHqwqiCEXbJO5tsFre1UhiSkugUOIPiEvETQigFlYZOZoA5pa1Kg==;5:AQl+Ylf380HyCMvjUfBBqd4CgjAd57Nr+bCrW/cA+7bULPucwTZaWc54r2BoWvorWsfC3XFPK/Tjvi4y+DOSj2+oc33ymmki79zYphcBfudY7xQV7BeR4RWDYS66VZ6sEGxRvfuYg/waE/ohwkN/myeTanw8noQjJbEtaerJZI0=;7:I5lQV/SMNcIUF6vlu0TNfKJozPT8N5/2zCBoS4E8YGW71YlKDMcsNEzFoPT4ohdjshL+EcWQ+sDZGzCCSMlzP9t8eJ23jFkr7DaA5HoMkAmi85eMaj+KI5vSYLVej2UBQtezfDhe2eFYh5IoBBgjrHqyaioaURkUgliqq8jT7MhZ01Mkx4pUwLc7goYF5zTneHq/43iK6bAOeb/Pyrrn0etnhHPeuQFGveoUUkB6ferRnRdePDvBKszB6lTT6/Iz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2018 08:19:50.1816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09692e74-3d85-4447-a145-08d625e45490
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix compilation warnings with nitrox_debugfs.c while printing
atomic64_t types on arm64. typecast the atomic64_read() value to u64

This issue is reported by Ard Biesheuvel

drivers/crypto/cavium/nitrox/nitrox_debugfs.c:62:30:
warning: format ‘%lld’ expects argument of type ‘long long int’,
         but argument 3 has type ‘long int’ [-Wformat=]
  seq_printf(s, "  Posted: %lld\n", atomic64_read(&ndev->stats.posted));
                              ^
Fixes: 2a8780be9c26 (crypto: cavium/nitrox - updated debugfs information)
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
Reviewed-by: Gadam Sreerama <sgadam@cavium.com>
---
 drivers/crypto/cavium/nitrox/nitrox_debugfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_debugfs.c b/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
index 2f1e74ea846e..5f3cd5fafe04 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
@@ -59,10 +59,12 @@ static int stats_show(struct seq_file *s, void *v)
 	struct nitrox_device *ndev = s->private;
 
 	seq_printf(s, "NITROX [%d] Request Statistics\n", ndev->idx);
-	seq_printf(s, "  Posted: %lld\n", atomic64_read(&ndev->stats.posted));
-	seq_printf(s, "  Completed: %lld\n",
-		   atomic64_read(&ndev->stats.completed));
-	seq_printf(s, "  Dropped: %lld\n", atomic64_read(&ndev->stats.dropped));
+	seq_printf(s, "  Posted: %llu\n",
+		   (u64)atomic64_read(&ndev->stats.posted));
+	seq_printf(s, "  Completed: %llu\n",
+		   (u64)atomic64_read(&ndev->stats.completed));
+	seq_printf(s, "  Dropped: %llu\n",
+		   (u64)atomic64_read(&ndev->stats.dropped));
 
 	return 0;
 }
-- 
2.17.1

