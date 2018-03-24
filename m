Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeCXSv1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 14:51:27 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:57948
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752579AbeCXSuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 14:50:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org, bp@suse.de,
        tony.luck@intel.com
Subject: [PATCH v3 3/8] efi: Decode IA32/X64 Processor Error Info Structure
Date: Sat, 24 Mar 2018 13:49:35 -0500
Message-Id: <20180324184940.19762-4-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
References: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:404:13f::22) To MWHPR12MB1919.namprd12.prod.outlook.com
 (2603:10b6:300:114::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04c2adbb-751c-4d10-4ef2-08d591b80c95
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1919;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;3:X9jn6SsYdHhfKGKO2xaQOfK1mYzaglfq80/EKvT7BciCs9ebDr/kNMI+hFRHhS4vM0kNF3snn6Z8iaXk8JPKCU+Zx4tTAw2QmPGNMAe2hcPT00zoJi1OJ8zln/gX+P00Qcxcm4u20o3lACVzAdFMNv3FXR4DHwo0yhrqx+Nw5huEFadmfPjM+zltTKRWQuhFrxwNHy3JESqKcxOZuwhHAwEFMglCMIzpU/pXCz2wugnUy45MCDMPS/TBtjl+Kq4O;25:MAyNhT2oWhxgpbGTJMmT1YVe9H+nKeimKVMOuR5kGewRUvb9MI5Uc3+6yufF1BYKjxjzG91LT+GOrtDPgHjdMPzcUfEWocJq2a0LORWcLipd0NpdxNI1pu6/SzO0u/x/eHg2B9hkq813rRqT8JIUAxaYDoUilSzOpxOAmlNTo+d8MJaGlq7DrtN84fMYJCGSOENAJds+bZP4c57nEp5c4StYk+JxR19TbGYG1k34lMO2iLcledoBUwi3W5wT1CXRvHp37WmCPJza+bjrbQ1H5qWBQlnKW+v7RIczKxtNPuKhqcIyLcrBaxmjo9mFkPDDU7rFenwiJjJO93rPMfwVvg==;31:53NGaP3L3FURIWpCBm36WauLgS79vgeJcKGMYXK+vnWvMHh6ice6Hsuaz7f3rQKkA2oty/oYOXeTncWA0pl/5bdBUVMF+u/Zf/wydnLFIpepdbQgebDPQVf78Ii0J7hWL1HtZfrxoxXarNbXjZxRofd25raKOZOK0sAXqeTWasWxN2x79/vanAZXClmXBHsgWaJmquU0YTN3t0nqWIu9FdK8v7toT6Ea2LrDG6pzzaY=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1919:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;20:5+SNbRBFEHOoT1tZlkz6CKdLgxbA0kcR7cDw2AyC+w7M0PwUZWT+fzrkJrgw4KnigZOznENikxW7xfj8n+pCJbvW9cmFfknnLIydMm9T6L8OO3ZmbauonuRFsWiBsdyuDgUEiav1q804L2bemxo3I6V7nUV1HTMBe6Q09iB3ztFseTpU/NzK+RyYNjvRWphS0qD4z4M75ETb1B/d0w55OydIQaR2g8Ptf+kQKkOxEDNWiqEHT24/kpk0nMQHONWMer6YZd3D5lTH3FQoyJqPlGkWB6z+e/IBamYBHiXjAcCpVewjfwU5MJRtXdH+JnhgMenROGN+i9iY7vv12xKzRw+XD6aGNNX/VFFWJaTCYyz1RJxhRAKKKz0ugNM77vX/OiDRMMU6lT8F+OkNNp84Vn1IdpWT8L+8PyQIFmC45WsXSdIoKm318qAjSU3a/QWy8fngQzExFLNk+IdY2k7ILTEL3KPI0+oLJhHd/JIJt8Li9hMeB1dz7aDxhepGjk8j;4:cjqe+ezUxGMC4yf7WKhktMuqjVpCmMtrHBpITsRCWMFrWNL03YkM+t9xTYiY6iBubEOj8waLt8MYL+9d1A2VIvTn144aypJxKidNdqPhzT2fz8qJqErZoyWw/63Lh6XMm5UQ28fFxF/E9+SM2pXpojHegzOR0yxAc1JCphn0lgozYx/szMReNHDgdahr475nszDgmP4KI4wnGLCX2l22Epm/Yaw1cHFWhpONxbnkqTbS/TycMA2huZHZ4hFZfxnQrxeAu6Hc0rlLRg4bO3mgSJiwXwQcrEM4TCqPFyOtaswoC90ByURFlsLrSXlc0+T0HiuWTlMl44dQ2ExY97MZy4DxDOTv+fS1Yqw27k3hnBo=
X-Microsoft-Antispam-PRVS: <MWHPR12MB1919C0311823081E30F122FFF8AF0@MWHPR12MB1919.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1919;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1919;
X-Forefront-PRVS: 0621E7E436
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(39380400002)(199004)(189003)(2351001)(2906002)(66066001)(36756003)(52116002)(316002)(4326008)(51416003)(25786009)(7696005)(53416004)(97736004)(5660300001)(106356001)(16586007)(76176011)(68736007)(11346002)(2616005)(386003)(956004)(7736002)(86362001)(47776003)(575784001)(305945005)(446003)(966005)(186003)(2361001)(48376002)(72206003)(53936002)(1076002)(6116002)(6306002)(3846002)(16526019)(26005)(6486002)(50466002)(105586002)(81156014)(6916009)(8676002)(478600001)(50226002)(8936002)(81166006)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1919;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1919;23:f1r3bviywR8YsrtWhKxXEbj0vDh3F+Xs7fLhdgphy?=
 =?us-ascii?Q?ehoXTe5BXpMpkTXK4U+3KrKTXIRuIG90usaU09TDP51tTTbTAghykHFuQ19G?=
 =?us-ascii?Q?Ptat45BuxAzfnkgUDqbtzH6wVFoiSI70T1I2+l6Ve/+pQAJVE9Nu30BXsC+G?=
 =?us-ascii?Q?aFqQW18JCWIl3PaD8BEH67yWcYRRFy6fsnaOP3QhK9X/zyuH9H6Tm8oQIUD6?=
 =?us-ascii?Q?WOPGJPVbZs82zgC/6IZ9mp5V02fxte2ytfNnH7iaKcr18aXz8MAB5AgUaGuY?=
 =?us-ascii?Q?fRVlzB+vc2wRmjCw9hVEdYcSSLq+dPlqW7aonFqHva7Ln7TbnFQF8wj7U3Mv?=
 =?us-ascii?Q?5lKh0x4c8jNZuYCQeEeKGkwXjvZRfvlNJYZGzmUlmL9cjzC6+h/h8nGL4ayw?=
 =?us-ascii?Q?Y739qP+G3uMc4b93Aq20Kc7Ja6J45mXXafkK22pVbfrWLJtHi71a23glOTAW?=
 =?us-ascii?Q?6gZnyVd1MPwvtShlpfzG4Kf3UrExeLdnyPRTpA1eqBHvHcAK/rHWJ0b4S4oh?=
 =?us-ascii?Q?4mGFgNBRc60mvYBL5uzu17m1cXJLlp8OvC6NdrmUSrR0UJOWkrr5LRerSaAy?=
 =?us-ascii?Q?r15LuboxOcCITQ8APjQ5X/0FnWi+diSFbqHa6gJo7pr4l7Fh0AI3Rxa1FmsL?=
 =?us-ascii?Q?9RsNuUPrBbFFJyrR32pyqD8soeG9sE/uZrWGM6Yi2X68qnC9ZO9WjOF0adGK?=
 =?us-ascii?Q?WHPTMnuDcfb55IS3sQlMoeT/dAxMI4uq16eJzS/JdIh0oGe0IpPYarzdT9VP?=
 =?us-ascii?Q?//wHOglhoCnsRRd8mu74jaob+9EdlqfUUgzUf7EFlGvZvboWl24geiQcNC4N?=
 =?us-ascii?Q?TvSxtwBiRntPPfp6t5uHUqdYyluwwOA3pmUCjypkLhlMQ1zl3p6X/7RL9c9f?=
 =?us-ascii?Q?HIc6/mdkAMVXrYs3xOWomoBHDGLjDUdMb5LJLvmarnoKLxEI3mlMqWgqugcJ?=
 =?us-ascii?Q?g0JW8GMxuVYqj+ALR29HO7TMUobJvBEE+QBEd3gAK021APUZDe/kxATGahky?=
 =?us-ascii?Q?n+VTjlEI/QAZy+XTskEIlNMv1DLNAgYMBUVyn9YL7e3FJ+kSw23eUANKevVq?=
 =?us-ascii?Q?COcLPIW4KilKkmJEw/Q6ZMyjlT5myfmXhCtma0iAgnOs4h1eRQ6SNjW2DZEt?=
 =?us-ascii?Q?f9tvEdi+EVrnS/DAcfg0/tf4l1sZMNAOJFpiR8lXJR54PscFim9npiLJd/tx?=
 =?us-ascii?Q?pEp1ZPJvVfCAtYz69Hgf8J26xzi5/G7hBu13qvNXAZgw0FYzU2Xq0aBLXYSk?=
 =?us-ascii?Q?BdjnQ1lmUm0hdf59ho0IjucYNDZ15Qrg8jJPC4mqoFxHVwWAY+7cGI62dOfI?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: IPYl83A5B2OerwiD4J5EXxC71tP8kchjFbM4i7G/MQol3cI7IcvOR7PSuxhLv1vDUGc5/z5rjWluwndD8AXP76CnKilhzFMBybBnNP9r9AUMh7wZI9ZybcPvnsRktPzz7muDl34rrFzx0yZzSXaeQocP6SwTmQ7Q8yF/z+YBvf4zdpiDMDukjDqx7U6x4G0K
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;6:3gg/gYwBF0fx6NEf0QgIpmvYqsigeTk+3vj/WxXe2v7Vaxk6FRlXe5AAF6aMcx2cgKzg85Vl3gFXnlK/pcu+xibUCFrl6PKPXCZNTFhrZq/aRAFTwdipX0gl4vddF8FEOBpnaEkHWv5K4ZdcNVyx4puu05X5I3fQM1omOBczDRVxr6ZD7hi7RhbgzGtMPYNoKif/LmsvwNf+6YkeojwiXFl/w51b/azJgE+woFO2ASlpHMj8asJWplFNv9UDHqgw3XLHY/NjHTbprsLNMCTjc9O3LIW2lZ+bEzaLPdAvy8XCvFvprkspPPfZ5EoCW84dleQCT2MX2TaKuf140zENOJ0kzav0L3x69VqMEYxjBET4vAUFmJ364AJNCRuRXotlSJrZwxQk7Kw9WuFJmPEShVRda4p1uVJU8+DoO303jczEKz7piAfozK74eJKlxU4wlN93t3iL46v+GPqQDWUoTg==;5:nSjAJXrSypouolImM1M0GhzmfeEQHpu8eP9zFbQhMMrzWzHHmU3fUXpak6y6TmSc4jlrIWS4t+F6x0Xv9jrFaUK1FV39d+ex4TngDWwAY+qX35fwK99fW9CmKl+wwN6BWAh4blbPC6eVrcECGERLxSKUA9Gi+8aTeV341/QtZVc=;24:cQQVJm7U8Y/WmRzRXgAq4k5DRb3fZxe9JNyLnSAq/tA+Z8VY43pbIZsJk97lgOXEBgxk67jou4U6boFK5PdsBG6Kx9XEUrTo/klttSvEHOg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;7:uMhPafl4GCOpYJAnsnnNaVa0lMu3gibb7p6ts2LeWP+4juHII3V8aAZ4Al+uQwEVFiA3iDoqQk+WpSqsuBc70d/V6lLNcBmXxRjUJX62N5LASFQMwCnLrpf0gLLb/GrKVO9ZsDlUjlJOAr5ypsTtClAnIGM1PR5DzynnUhC4gd8NWtQNUAWALM4mE51sfGErfQlPzGASCQ57Dr9yumN/vOPfgG9+4NQ8Om1D+Z1pcDLiSD1u2TdIfFPWf96j82mH;20:QoYJbVBqOWqO/3ZiEla2WPxPfENpW7AmsWv1AdMbTwX2MMqvjE1onXDFDgjlju5YDAHG8aiaVUF+R8mdvrK+Nj33aS6ckJidYoj5Ssjr6s0xV1pLw5Eu8TxmrNnMXClmfvMOG9+2Cqmgd/ixzpszNn4dBJLm/UvM858/kXLM/9TbW039RVHOlbXcYYI+FBq+m7AN6u3NZmGp+9ZiTm9lxMMwC1JO1QTSdq+LrPwR4fo1Y57Gtns2oyz51RUektod
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2018 18:50:00.2821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c2adbb-751c-4d10-4ef2-08d591b80c95
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1919
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Print the fields in the IA32/X64 Processor Error Info Structure.

Based on UEFI 2.7 Table 253. IA32/X64 Processor Error Information
Structure.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180226193904.20532-4-Yazen.Ghannam@amd.com

v2->v3:
* Fix table number in commit message.
* Don't print raw validation bits.

v1->v2:
* Add parantheses around "bits" expression in macro.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 863f0cd2a0ff..a9ab3bbf7986 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -3,15 +3,28 @@
 
 #include <linux/cper.h>
 
+#define INDENT_SP	" "
+
 /*
  * We don't need a "CPER_IA" prefix since these are all locally defined.
  * This will save us a lot of line space.
  */
 #define VALID_LAPIC_ID			BIT_ULL(0)
 #define VALID_CPUID_INFO		BIT_ULL(1)
+#define VALID_PROC_ERR_INFO_NUM(bits)	(((bits) & GENMASK_ULL(7, 2)) >> 2)
+
+#define INFO_VALID_CHECK_INFO		BIT_ULL(0)
+#define INFO_VALID_TARGET_ID		BIT_ULL(1)
+#define INFO_VALID_REQUESTOR_ID		BIT_ULL(2)
+#define INFO_VALID_RESPONDER_ID		BIT_ULL(3)
+#define INFO_VALID_IP			BIT_ULL(4)
 
 void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 {
+	int i;
+	struct cper_ia_err_info *err_info;
+	char newpfx[64];
+
 	if (proc->validation_bits & VALID_LAPIC_ID)
 		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
 
@@ -20,4 +33,41 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
 			       sizeof(proc->cpuid), 0);
 	}
+
+	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
+
+	err_info = (struct cper_ia_err_info *)(proc + 1);
+	for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits); i++) {
+		printk("%sError Information Structure %d:\n", pfx, i);
+
+		printk("%sError Structure Type: %pUl\n", newpfx,
+		       &err_info->err_type);
+
+		if (err_info->validation_bits & INFO_VALID_CHECK_INFO) {
+			printk("%sCheck Information: 0x%016llx\n", newpfx,
+			       err_info->check_info);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_TARGET_ID) {
+			printk("%sTarget Identifier: 0x%016llx\n",
+			       newpfx, err_info->target_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_REQUESTOR_ID) {
+			printk("%sRequestor Identifier: 0x%016llx\n",
+			       newpfx, err_info->requestor_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_RESPONDER_ID) {
+			printk("%sResponder Identifier: 0x%016llx\n",
+			       newpfx, err_info->responder_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_IP) {
+			printk("%sInstruction Pointer: 0x%016llx\n",
+			       newpfx, err_info->ip);
+		}
+
+		err_info++;
+	}
 }
-- 
2.14.1
