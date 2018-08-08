Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFE4C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4C9216E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="rD4c3ObD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4C9216E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeHHFYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 01:24:38 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:37676
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbeHHFYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 01:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhm00G9HlCZ/d5eQIjHIEiS1lE5HmG/cSc5rp+1M02M=;
 b=rD4c3ObDWlahJtoDbeiQ+PvPYSmJbg4yYtWcS6faPmuM3GOoSgFWKmLrdVaWI96CBLeBLv3dSr7kOuw+mMdUVMPvi0rXnHfOqBd2mNxYxTN3aktEJoup+DRSgjkAH7bTOemXhXzY7/8ag9I9YvWtZcvmDh0j2/j5Q8O+VLfe3zk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
Received: from ubuntu.localdomain (211.178.16.139) by
 DM3PR1101MB1135.namprd11.prod.outlook.com (2a01:111:e400:5aae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Wed, 8 Aug
 2018 03:07:04 +0000
From:   Ryan Lee <ryans.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ryans.lee@maximintegrated.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     ryan.lee.maxim@gmail.com
Subject: [PATCH] ASoC: max98373: Added software reset register to readable registers
Date:   Tue,  7 Aug 2018 20:06:38 -0700
Message-Id: <20180808030638.8085-1-ryans.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.178.16.139]
X-ClientProxiedBy: HK0PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:203:72::25) To DM3PR1101MB1135.namprd11.prod.outlook.com
 (2a01:111:e400:5aae::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00389e1c-b3db-41d0-2153-08d5fcdc05f1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM3PR1101MB1135;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR1101MB1135;3:Z7tCfvAfZZbHkgGdRzsyP1Nl/N3sDQlop1sFvdq4ivdZ5GLhfFIb5xvyhORVClArNahJgEHgd8Gg1j84w45gewR4baeYCuofr8SUzH+45O2uEjl7h9eCcwbOOf1Y38NeK9MtMQyz3rf2tbqZh/5oYamlok+JqFcMtRRc30oJh14T/98WsI/UNqNaj3b/E/AzOACrda46zllqEcFS1uPYq8IRglufL4PqN5kTpDjJr/hr94OTsCUnbcsxHZjilK0P;25:gbfU8VtZq6cIbDfcUPOZkRiD6oRfPLITaUiRxTRkOeZZ/ecuRgYVJLAgxYappfnRHRKpoJan8kGKMYq2lSH9b+93JGwGERqvAxOoXUSNoUREB3+dxMaaglBixLJ4s9d1zlbfyBP8a1qAF7xO/83q8rNbZHKxTd+e+n23+9cPlQKEaOZrYaVnyRbdph+K67mz1Mntfk1RFFHWl1TlM8wKdsUSsZy7BT6iGYbo2/igyPG4U+4MTyYfREVezcuh+SbcVwJR+wMuCUiNl3cc4FsLFVthM2/XkewKmJdSgHRB5qv9OiJJzIiP4wogQzy7YNgBbpi1npYfwytp5eSOR5yqJg==;31:fyI0xr+8cJYK4TApjY740KXqLhG3ek0AOsv6eyEcAQTtZBDeID0b4npa62APgnATBaufr33GsRrLFKxG0I3XqoaCl10b+W3MFVxSomDYc3oMbEgqpmgD2V8r12yU8+EEYKQ0L2Co44xEY2Fawx1hyQu9y1VnA35Qz7BrVHFEM6pCIrWCdidUoQkjlWJFY50xyCcuHU0JwlpEGPHZQn44rloi+SE2L2N4ymDCxOj9Do8=
X-MS-TrafficTypeDiagnostic: DM3PR1101MB1135:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR1101MB1135;20:ZPNqrjyC/r97vvzn1eL2iLRdIt3vpqYI/Aah36r5M80M+cBA5X5iD19uwX2TY5Mo+Prcpr+dyxjOzoFzZIHpZT4E7dpq6klAH5stMT8UwvRG5Yb5zOfcGwm3XD5iejU/L7fNhqyeGRxuxyAMJYy02u2hYAhnpjJ+R0X1ws6jsewK+kMc093wgjiz7WdQqPc3ZNpVth6vrxljQiLrnL+i20AbJAR2GaUesOXtDPo2bAWGhwrozequ5T7lZo7KtLdXVuI7SFBHMvPKEkZkoRFumGDn7M+rCMUTLsqo8MGScZcTz2fS0cj03snvcEV/U3fdEwfo8urHiLrqOvoW84PdU+6XIT1rUkiPAN7witkENKmuJhiiPEsEoz4Is8eUNrofj29ENTNbnk1KryzdT750fd+alGAnlgZK+3iprA3b/2PYWfINmFMhFGVyGDhzXar11INUZrdCibPbfOze0caCuAaDO7xHk5UIA9VoKqC1kCS3LWrjqgBUbRQSAWU5k9h1;4:6tKBkgOJ71yIBaG5Kj8dBFbdCj8eswMNzN1dy1+U3SrUTZEpHonfC+iz1wpQajqVTcHTfpkz0msXfdg7wV+9ekuIVt0XPxCjbyMU9FkillDDre31jf6D1gkpnNaaCr83Y7rdshebX0qLhrCzixutGHY6kgTD0t/6ixb7tLuC9IazoG3Y/CFF2jRkgXnT79ICRX+9vNLKMtD0zJGqvRO3YM92zwOUwUJ1qxUqx7niTjwYkOkRUruiwnjVu9Mqbf/A5X8uZxKJDeJhhRCc+dOitf/jZaQqJOZlczkwCguUiLdu8s45KAEeNCCCjtt55l07
X-Microsoft-Antispam-PRVS: <DM3PR1101MB11353531D9BB72365F306F92E7260@DM3PR1101MB1135.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(108721460000369);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM3PR1101MB1135;BCL:0;PCL:0;RULEID:;SRVR:DM3PR1101MB1135;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39860400002)(346002)(366004)(189003)(199004)(6486002)(47776003)(86362001)(66066001)(25786009)(486006)(53936002)(476003)(4326008)(16586007)(2616005)(956004)(14444005)(39060400002)(316002)(2906002)(6512007)(50226002)(1857600001)(36756003)(6506007)(5660300001)(478600001)(6666003)(386003)(1076002)(50466002)(48376002)(97736004)(7736002)(3846002)(6116002)(52116002)(26005)(51416003)(305945005)(68736007)(16526019)(106356001)(105586002)(81166006)(186003)(8936002)(81156014)(8676002)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR1101MB1135;H:ubuntu.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR1101MB1135;23:vDzIhjqKHznymKzeKX/l/C21Vg2ZrjD5rz3OKid?=
 =?us-ascii?Q?Ky7Hkp/SnqSr+xtoHEMJhHF8HDVQ/HuCaCxp0kXSuA+o5S6mhxksRgwUpaqx?=
 =?us-ascii?Q?wfsgIdpm+VispDGxQepLZ4USxZHmvkuUsColYXpBhQGlJM9bV4LtgRvaplrc?=
 =?us-ascii?Q?twG5SqJKVO19Uo+Ec/LIOCulH1FB0Yvvs8GAq2DRo2WyrX4bJCh9MK3eyP6d?=
 =?us-ascii?Q?jtMCMn3jTpH1CX6iNn7lYk0jIAC13zwFhWy3Ez6FcvgkS127+slhHxAcA4K8?=
 =?us-ascii?Q?/qhb9Rh5ZSiEEM6WUjvFm2WqRzM3usYJ8W8AWjpAFNoA44RU7/0Bt9U5YGbr?=
 =?us-ascii?Q?C3YnURp4UtSy2hD82kFpLqkCxqAryV7WR2x65En8H2bCFbbPfVPdqEAc2m6Y?=
 =?us-ascii?Q?bP0MjUz9xmYy09ukrSBUY9jM/vrn4N/6WWhrRKEIH8OzOhFpss5up5c282z7?=
 =?us-ascii?Q?U1hCcBy6jyhjNgFW22lvzsE6gTv06FR+ACaRgFFoRdhJRlFOdkCJW8Hb4O6p?=
 =?us-ascii?Q?aaD5vy5NBX09i7e5mUdVvaQDYlIi4oAbVIIPCei+YfTqrAjxmUqZZH2Y2HjO?=
 =?us-ascii?Q?NWv/FijewUtJ6SneXUjb5o+mN/WLwdIpxZhoF89lsU7bHShhS3MyayG7jZRZ?=
 =?us-ascii?Q?VSW+JjgfN32EqYr1iRe10P84363DPWpPFiPSmXhYUV//U6U9BQvJLqR2Llh8?=
 =?us-ascii?Q?p0Ve8tDRQq2KxIV1Vf3XrJsYDBD/KyYolyPeEEgpYcoITTaYLkjoUwOSn9ZX?=
 =?us-ascii?Q?cbUkimjXhzSFFWvoUtyGs01C7Oz+6YsJKUGVGhe6QkQXPXJ4R4zP+VFbtuYL?=
 =?us-ascii?Q?05fcQf+9eO5YdnD7i4D/A0Nfp9g09JkGubZU01/d7EN7D+OelSe1o3yt9YzF?=
 =?us-ascii?Q?v7xCB8TuqAfEZCaB17JpOq+So08D/xI7Hykvi8VpDCWO6WItnJ6icP5C7NC0?=
 =?us-ascii?Q?h4u3SSkvERusPfP+zfBYwsTOu52NGsofFDAVTi3l3v7/byLL/IwO58goxPAj?=
 =?us-ascii?Q?odGGfRfo+wtBliXvZOrM18NEoKJm46wwUn1GwsX008t52RqEHL/XGMOL8UJk?=
 =?us-ascii?Q?9jcCIyW12JuztN5O5WKgNcEh5hFK1wjmKXh9bu1fgksIDDyPljsbmJrqs0n8?=
 =?us-ascii?Q?Beoyq7Rs3Ms3ylhRkMhj8zqoLPYQ6WHNXh63ISfUBRe5TKKdO7exmRx3dl2w?=
 =?us-ascii?Q?Wdi/5xhoMH8hOwW4+mmGoxmdW7+HoOkl53xUX?=
X-Microsoft-Antispam-Message-Info: oXSTXS/ysdgGEV92JU2akex61a9S1XShHEiF4ynOUlFoTZnLGDZJdae/Cvpfi8UTeqF6qPNaQnG/UoKGflH1WOvKyhw/R/owE0u66mTSKCTjIO0scDY5wnbjflihYzL01bVXW45HlB6xCL6O8BLzbL/h/3DT39EgUBcuYmD61JvCFMPJuFqwjOldKffP58cObVEsBoFgl8VH21bZEOPFKMJLbZiBY7pSmXvkCTcC7MEAmw50aZIfLv+n5r/jGcVx/EONB/9aTphZfUZO4PdGqsOXpEy7KJfBC7b546HkqPhtMHwx+H+e4vnAl5rMRyNzHZpAc4hOJyMwIjM4vrAYNCQWnj6Hqi1i8wLLSR+ea/A=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR1101MB1135;6:zXCid0Fego/WUmXXXfR7LW+eY3U5NlQ3Qc/GEhO7RvuoY5aeWfZRYpOQTvzHwGhPVNYMEq9JJhQR2mlgXMBNhmrJJ5jwSMwj8LtVlV0a882rJsuVCUEf5ydC+JM4DVPB08nkI4vDjbhRyZ6zFWIrr7sSrlczTc6zUSZHp6m4QjgGZT+OQ1PxUb5+1Npo1wSSCPdSRGTY3roc5zXOhrG4w6zz3ELeg+0i+gcoF6po90QFVgBZvGq4+JAE0Mpkm6NIe7PwuNUArOJ5kXjqVzRce/LU8w06kHJ1qLkdwtGE6Cw3Cy94K1vPMvpZxK/IeSXCHO/peXdUIBC1HFCA7DRnh+7WqKW1cg51P2Rv4HSpJ617cF7U9H5VPrf+ObOcKwHBPP7A8R9+3nDIIKTQ0+d+eL1kQi3qxSpwi+Cikms9ob2tGfhrzQNPFy88tOT9u2g7etbcZzZbncPXhaQdtX5Hpg==;5:1TZ2dCBuOfBC6WNwulsZjbrCyMzloCij5fZYxQDoP1xaMnPmSv0YcdDpd6dx8QHWOUfQnWRKT2cxO10/4sqdgNFWOoY+Z3VVo8xpz8F7/D/Ec5orzhx2EtxvF3ALFqAGlw+DN2q6Jrzn8R6suq5YGse6MWhG/5E1EldmjJ/f9hs=;7:ianmZe71sLWnj81nqGHrPLBfdbqeZi+kGzxCv1NGRril/39TyrH2Swwm7dT8h7uQBOosi9KT0mrBuu90Dno84/Hznq9Ka5MD2SsIGc87uPoNkyVOvkG0Q6MoMO5CajtczQpdcsyskd7FPCFOAHUQwyKkjQMI9WgYWvlEApzgv95wp4fakzAi9sbGQ7JfFlukwCYxmJHfK0FYoshp9j/6fpre7PnxE2iFowzd8auBunBfTkIHDnU4M93cyQmKPklF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 03:07:04.0814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00389e1c-b3db-41d0-2153-08d5fcdc05f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR1101MB1135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 Changes : Added 'MAX98373_R2000_SW_RESET' register to 'max98373_readable_register'
           Software reset didn't work properly after suspend/resume.
 sound/soc/codecs/max98373.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index a925861..92b7125 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -488,6 +488,7 @@ static const DECLARE_TLV_DB_RANGE(max98373_bde_gain_tlv,
 static bool max98373_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MAX98373_R2000_SW_RESET:
 	case MAX98373_R2001_INT_RAW1 ... MAX98373_R200C_INT_EN3:
 	case MAX98373_R2010_IRQ_CTRL:
 	case MAX98373_R2014_THERM_WARN_THRESH
-- 
2.7.4

