Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbeBETZ4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:25:56 -0500
Received: from mail-bn3nam01on0087.outbound.protection.outlook.com ([104.47.33.87]:43952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751655AbeBETZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:25:24 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, Len Brown <len.brown@intel.com>,
        Borislav Petkov <bp@suse.de>, Kyle Huey <me@kylehuey.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v5 3/3] x86/kvm: Expose AMD Core Perf Extension flag to guests
Date: Mon,  5 Feb 2018 13:24:53 -0600
Message-Id: <220fdc3767d991c2ff5c32267b166bfecf25334c.1517850303.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
References: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CO1PR15CA0095.namprd15.prod.outlook.com (10.175.177.15) To
 DM5PR12MB1370.namprd12.prod.outlook.com (10.168.238.21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35934753-872a-48f5-ad90-08d56cce3296
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1370;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;3:vDT4Czkd1A4sM0PCaPFApuk20HeamoiJgU3635JtdoHONVDaA8x5rUkiytzXA3dIpOHFQp0WKkvKOhEYJmpQMdeFFKmQOXSklkebHTKkjI51qpwdE/8nojjQYlX7l0By16PD6wWloXJ1KTe9JGi9HITUqfFMQoBwfLdwbVbKhtW3nrLvca+ZXjRr1Ddsx4Xc9oIytEgvQN5TmR9HmZMSFlP8WLk8xiYuWJgglfyZyiyLIwsvggJ6lwT/JhldoCLs;25:jD5JVZL+NP1q1nEF+d1Q30SSJzsEeX5J4W0txipSLDBdWqPqvCX0XwtdtrgIu5jEcZDTPrUWg6W6c1aKW9IkM38iMngJ3I2rAt0bwrElIK5zLVoI7I2o4/H06oib2qQx6NnVUGH6nqkbby4nInWh+xxICq1jXnG+VxVHvdl+wn47xR3dXccMA8zqyEhcve4eJKF2qoD6ip3or41pJGRZDncG8I4Hmefv3S/9SRAsfoKWIa77FAoaOT5IP5b7SjoPit/tYVPUOg/iBUn2sN3uCjmA9y/J13sdg4XTWwlREc5gDiViKx77C5YAc/ZB0OjxBx6X8ZT/G5kPwPcwlb6g8w==;31:eZP5aRcLCY/f1VN1WCxdOi/6ePVmsT/2h8uQ+uNJM3fhNcRpRPe9TUecmogmnuISu4++dqoo52O8EXFXjb36ne9ugY6tW53eRE+rHrSsemYvnBLBgreKp4G9rBOHaJcYKsujZ4BlRwuhatDHnrtDEc0q9CI0VmzFwtVl755+FcqQwhFUFiz24rrb0sNaZrGFm2ardOw/0P39u2H/0mNv2csmqJvcuLzox4NXAiWAV7Y=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1370:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;20:FJyk3/RpAKj9e99RcnbALZRKRwamG8TPWOH8eCgpFtHfdJy4dIW1C+rI78AEG6ur2FfzOHNFqwIF0Ae+zM35hXF+WexWeWpr8hQ+3AApp85ZVTNUIrTW8X3ItHzUvA0/a/Xc3W+REc8YK00JWg8B5VkDxNo6CKZfIuT0F1hQIlPHAy6Xt02PIuqzQKHnjaAp3n8GDdZ53c4Ve4OA+VPuUVixmO57jtlh3WZ1VNASCtTqW3XrJJrRNXqyNn93sIsRPk8RaQc3sw3/DsS5hypykgBQErnAo/vWb2Y+WQe2AV+94V+BEOby7ttP8IUpxugC7aQiUN81k1XsufkUQNUue7M5fuFlh/sgpPGxcpuAgSfn0gle/P27HWEdzHU7wMmBdpt+PW4Zw7Ef0epjotUcTxDWd7PRPZhEkE8PfMWflezJah+KkMaE3gpArf2Nkv3+ZeOMelua4sXAqnFgSg2kWhEwhanoxuH3f6iCMkfrU27ECeV6s3dMpxE1UkilK1Ij;4:AUQQhCLpEf/2ygTV7gZKOY7u7Nqc4fwB/7s5XWf9KaVSZv+ay8EoSsM+1+EMeqZNePwXoJkG6V5cW7uTsdzJIntpNEd8FSG1tphauNDr5ONjwL2UFBaGtH4E/Z+6zT909j9ktViwEkYoAb9Os0rJAJmOpXh89FKzW8UZuIotXb6s9aROJZJKBGl6VmRwv4AWMGqEYoL44CguDKWliegokmjm8ghoYxdlzA4aqUPTGqQyR29J0kgo0F4fpqX7kzxuMVvkhknea265EzJwD+i0TkZ2wOBBhdTqMMJGRqw5PGaqofm6t/G59av64h8uDU9u
X-Microsoft-Antispam-PRVS: <DM5PR12MB1370CABEC3B9B79EEE21D7A0E7FE0@DM5PR12MB1370.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1370;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1370;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39380400002)(376002)(39860400002)(189003)(199004)(48376002)(68736007)(7416002)(7696005)(50226002)(5660300001)(52116002)(2950100002)(6486002)(6666003)(186003)(305945005)(47776003)(76176011)(66066001)(59450400001)(4326008)(81156014)(50466002)(8676002)(97736004)(53936002)(51416003)(105586002)(53416004)(81166006)(386003)(7736002)(8936002)(25786009)(72206003)(26005)(478600001)(118296001)(86362001)(106356001)(16586007)(54906003)(6116002)(3846002)(316002)(36756003)(16526019)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1370;H:gi-joe.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1370;23:jUbN2x2vDOna0uamT/JtRw1ueK4FpdTcqQoWQHVkV?=
 =?us-ascii?Q?j3Cz6mQVT4HBCUltXRqGnQGpjYTmJfzhVNMeiLO2e2y2P4C826cto9+o8wwm?=
 =?us-ascii?Q?DtLhOwTXV8WzcBrSs7FEvPncwVKbxrGia1fycpLIgyaDyB/DmJP8slPmXZwc?=
 =?us-ascii?Q?9Ukotq7s31K4pjqID7BNzB91o+s/5KQCVlW22YoTLPz9ATTR4p7Ibeg9MA35?=
 =?us-ascii?Q?Ta1Et11i7ms3LNrCSU3253kpibyoiGCgQRgygdSxe0YKkl4yKFSEy7fw39Po?=
 =?us-ascii?Q?wOtFXWEIpaLBtEtUWF8scIijukhgmaCpIITq9fjqEPQDANk2sJFABha2L8VE?=
 =?us-ascii?Q?4WA7n+NscBGPVn6J87SBleupVwqD5UgiMs4WJukV8OFQ/vRBuTFoyHfcU1kL?=
 =?us-ascii?Q?42wRcz5pjOF0zaAhlDI35xqTjUI3CcOItRI+GvQ3bxFLJYhDNyHwxlBtJaxG?=
 =?us-ascii?Q?PXdgDIcZraBHGDOiM0kKxlnyQh1SoliJjdreGWNifxNYKe/TshfEdZzjTZ4z?=
 =?us-ascii?Q?1DC2FKwp2QcWpv5tkzkSIDjJdoCbspbd/SMTBfQWI6DsA3R8K92kF6LJQ1oN?=
 =?us-ascii?Q?/k1WRVVqfQrsB5REPzn17+anCgmOqh8Aiq0zV1la1j/5AVdFKBQKG4H6Hbo2?=
 =?us-ascii?Q?TCzzIpVAe7SPxOE+SEXRKpXEPVw81ZluauU/XziPEyC7p680WHUAqlr55T28?=
 =?us-ascii?Q?QmWx7h70zvRxMOSVqm76j3CFdwLz1xKJfdzBakxHrL5j588GwFr6v+VVrjSQ?=
 =?us-ascii?Q?Q7Ty0XOO7uM/kOmtChm2eZYNS2mRay2lJ4l282ePVF7X4j6zdGB/LGcJdc0Q?=
 =?us-ascii?Q?1kHPdDmqn62R63JUWFEBJRPQ5m8ne3f+jvXtNfMP4WWuma4vE+Fb5I5WSpO/?=
 =?us-ascii?Q?OxppwS+YkbcAipMs0H4sGI4jHqe2lyKv4F6MAxzUg/RtsqwlvxHDde4YaRkE?=
 =?us-ascii?Q?YPpuPStL4rvPxM+P1iVmOKD/O/2pP+4EIu8UZh3DZOtrgRq0DV0AbxNAqKSc?=
 =?us-ascii?Q?uUHyBrKmJNE6lIJptTdrmqQyvUcItd91h2j3Hnrht/GyX29sIDdSls3Tz95d?=
 =?us-ascii?Q?BuLDtHdTJYmx09CeJzH7oBm5KEvJXsDOojuua/eCaAjKfOrgnzTKyccO0ZdV?=
 =?us-ascii?Q?+VVMzFWkbVHOQED2345/yEfcfRxUo2Xn/1UNgAO8dFW9gyHXIMujpXJ8aSgD?=
 =?us-ascii?Q?CopNzi49ZzT1v8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;6:kljr3mW86kTEie4jJnJg5Ibd1D22+HnFUwoz96h20oOn9kantck2EhTrEaYtlDyZbfd/mLJpKkDUgsRaUVP3ANqwI5Xs0KgvmaMy3iOkyZrs5yCh9fsfD7yYSSZZ34jGYzYWvGyhC7F3SbmihmP5qXUHJpqkW1PcH85h9n5aYZ2FYqQavWTiyOQmfzVxv5egY2OG+SCMop8qcIYSV0ktKojdF7xNhc2J6mlWGNiEQ5wZjYBd2hpp87KsMsE0j8vEJ55ZseV6zNiY94VrjguUPPWg1Pnc2buxgkeZdAKkTQJWNBTxiG9i09WJK2fTVfl7P7v19zud+GzbUJGpXu9WPT6viCKRmRUL3MF4w//Xmuw=;5:SPj2XlNyA/nK++v6S+f8tfcoR02vxFe+jQHgpYT5x7KPZCJ0V6EdKr81x0lTRxwNPUXf3wNUCC+ta1XJsY29Xqr9YYAaRBuIK5iObUVSYHx9gN/54iR5mZt6r+qQKvZky5tUgJDp+0V12+JfUF8LG0L4JrcM1Zs65vV7n2rxzoU=;24:xjJqDxnGHm8u42tnMOdg5PYBWxmMJRoRDr2VHNY0S5fXNPdoKXNOL45JiaaXMKR2Wggn11u9IArwS6yuWAE7JDHOCGw4JiJEEpqeNZew868=;7:g00sfrOKhasaO6wo+1/xkUBKyj+UaxCme5+m8rGihqhMPKVGAIIGOKEcRd2NXd0knm7Jklmo8cMJTRYxQWoFxbWhWTTOwudeFfTvuKThv/f4pb5RRKRtFLLBNExv4R9kp3f+HbZ0AsJIbsjH0cAwlVae/M+QKs2SUQ8hH5JELi4Dn50kEoc43CCW/27MB9VIvgPlgp7WTEWluHMvxozai8OIEF2i+as4npp6dV2CUthG9P381DWxLMP8MIHtd2rC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;20:vykuh6qOD/nSFdYnvEULymESf8rp4Efla0CYInPUKoirrWR3ZPh9pYUdUCP5zD97UK1BqdkxFp/XUPELgIYA4jtrrSOsKNQh8RwYl/yWlWXnr16gRZGhLb0L//1wPu1yAI2Gj3jfeCB0VJ3T+hSTgQ/5wB8YB3Va9HCS3tpSLA2DcgieFXWYFQRkw5931O88itTAgHxPrOo54Dh9Tt/8ZBjqUR5kXnpa1PPgYukvmqEwcmhcIoYTAtk2cOugGXcr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 19:25:19.0122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35934753-872a-48f5-ad90-08d56cce3296
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1370
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the AMD Core Perf Extension flag to the guests.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0099e10..de561d4 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -365,7 +365,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		F(LAHF_LM) | F(CMP_LEGACY) | 0 /*SVM*/ | 0 /* ExtApicSpace */ |
 		F(CR8_LEGACY) | F(ABM) | F(SSE4A) | F(MISALIGNSSE) |
 		F(3DNOWPREFETCH) | F(OSVW) | 0 /* IBS */ | F(XOP) |
-		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM);
+		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM) | F(PERFCTR_CORE);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
-- 
2.7.4
