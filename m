Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbeBASso (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:48:44 -0500
Received: from mail-dm3nam03on0054.outbound.protection.outlook.com ([104.47.41.54]:29401
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753094AbeBASsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:48:30 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH 1/3] x86/MCE/AMD: Redo function to get SMCA bank type
Date: Thu,  1 Feb 2018 12:48:11 -0600
Message-Id: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR1101CA0010.namprd11.prod.outlook.com (10.174.237.20)
 To BN6PR12MB1907.namprd12.prod.outlook.com (10.175.102.13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f6fc432e-d86a-4ac5-356a-08d569a46121
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1907;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;3:G7oPstpUtW1yszu8rtN/825P1wUX4mcB53IQwycbHXnnVwiLYriA5bo46jH5dAhjAvn6lLuklV+PaSPCljcAFWSiSBrudI6NaLrZjifeMFHhINddZyw3z2vDprcBpGrqP0QFmb+BNwMSKPd+aKEMDQ1ngsF081sjAKDmccqOMERaul0U1nt9t7ulhkm3lsiXuDTbN3EolXIN/HFOSzxPtGopQHW5mDDua2JmPJaHg3Wn5oCXdg50rY70Jmq4DJz6;25:SDyxCVC35re/cUJ+9GyIHhXERPBIzfELqvf5z/8BjzIYg9oTaHkZHARh3Ll+kuotG7ryaR7UwUUT0WslguqfLCHQiHi3KOnmZoB/zABLitnKrW1FSE7KYNtT/rc5pElLVmkqRZS4KOQ53bsfvGYEavcH1st4G3yiUvcfnSCFVb8pCJhZUzk8gUxtLeJ3s7Pxaa4Y9X/UAe0Om6cSZ5/SboAq4/MWM7OPS3wujUMnnWGeIGm0wy6aTjlfgRzfp29nUpHfhweeHsAdR8qO6WhBbmQGWBLZvHm2SeBO6G77xFhFy3EwuetpCj9AByRPV2pz9QTrxWeRLsl7OzhrXFAw0g==;31:p8+mT+KNDJHlGra20tZMAY6jkKJ00GwZvRoNRXQB7luKU0gWpjWpWblu9pZGONaj2nIGI7zMrntpshLlDch1f2s4Wf777aE6bDcNRmx079oHnPe4Pb1eByuaUJ133D3CLK08cQ650e+Dfqwrgxk7qoHFNUozO+x9f7wPh6V0EZQ0NcH6RDspabdoCvoVV/qISe+bkcMudAXI5q4W1Fx+aSw0fdEqJFA+g/gtUTTo5ag=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1907:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;20:xvMcPrA5vrNW5i2sjRUMhEfgKPl72UICu3DZQ9yhOF2nQLc+AMN+unl5uaB7SOTMgf9dtct0uITUtIpsUebQ7VzMk56pqD98R6osrN3iJfmosV7jemy+PqhsF3c3P4t5qCvQLXanybHwyQaao+f88ntJU7aa24QMpqSXlfwRYctBZN6UES3IlVBj9/Xjm9p5M09FOLNucbHSpqngfAzMdwT/DPRo54zlYTwJgSY9zTCbHzqj9RsA6DA4ztFNF7XLR5Pa5ukhdMOjIf0+vSwyeZoU0RXtmMNvAJmBupTTMfD3qUdDIlFW/Bz3MMMn1munBGHIgQ1nGT8w47Wr76s/9vFobG85/J5yCtnFy93eCYKE5q+wUVHIPorIrTFl8ipCXErnc1+rgrquKF4w1j9UJ4E+Xo8LGaQnoEff92fClDSxiBdUngLI+faZjgvs6OUOyvOVmjtYpjJQWMu5pmYCcTeyeq8WgrHpRYRfs3z7Ox5zzxqXth7MtYcVV+oexcsy;4:PNqNemB9gJdiOQssXlug0IgA0IfV/YvjU5zj5w5aYrHfITyxUitQUvLTrv5YkEPOXxQ0QYy8VCQ9H1HpIRGxB0heAHD1CH6e+EvQWEPCp7CjaQ4BJgmYsVB5PyjoyFsYyxTsOrv35r8n9KeZMZzNy+jZt0LjX4OWtsqrk9OhWCkswOU4tZba6WIIKDSHaq+vpuC0IRxssPZ3r2USsi5mw59QNtfFX1G51ENCvxK/t22RzypIFAr0FIoad/EJOrCGVBOl54CXL8i9C8FKo09UH1r85pUZv3/baXkHfKuapGRSJUKWe93PyVPPz3kEhzunoWaSSWOhw1cpRijudBHV1w==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1907CEA6C66CD5B1CAE6B1D8F8FA0@BN6PR12MB1907.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1907;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1907;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(16526019)(3846002)(81166006)(53416004)(68736007)(7736002)(4326008)(6486002)(36756003)(53936002)(6116002)(2906002)(305945005)(1076002)(97736004)(386003)(6666003)(7696005)(15650500001)(25786009)(47776003)(6916009)(26005)(52116002)(2351001)(316002)(51416003)(72206003)(66066001)(105586002)(8936002)(106356001)(50226002)(478600001)(8676002)(5660300001)(186003)(86362001)(48376002)(50466002)(81156014)(2361001)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1907;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1907;23:f2MTUXL2F15+xo8jOhDUzjficKw4r6KB4+oH6HYVy?=
 =?us-ascii?Q?ALcl6Ham9euUoLFR0PIJ2yEmb9dfCEZTD3rA94ObsUR0prG7VBJNuSLX+iBZ?=
 =?us-ascii?Q?FqOV8YHwJrmy+YhhpNucJjdIn+HbTCIaJM/bfDAqP2hPmK+nr6bKAxacm8fs?=
 =?us-ascii?Q?wsbjaDBJJ0622MoWrY3xnXmdULw23anX7iItnDdPWrLcRkK8XQY6JIRbHbX9?=
 =?us-ascii?Q?YSCYLWA59CFLoRZ3Eo3btn1FnxARAdyogSDrCe9sEyiEOXB4Y5spU3r6Vvmq?=
 =?us-ascii?Q?xDf/oS8TsmfDbA2KK1cqQUbWcYh+Ic0qAcmfhE8y4J3motZMmv40OYeIAmRx?=
 =?us-ascii?Q?viuRewRX/Co/hhg+dFve7dNvBhDu/r6W2DKi8M7pIq9KDcTO8cUVO5z+2i54?=
 =?us-ascii?Q?rEBhZLHzw0Jq5pAqnMErnmuKKdgg6NSz3CMidLjQPLbWWwto3Bzpyk6F3jip?=
 =?us-ascii?Q?nkuf9xbfpXtZEufhLEjQDq7VDWRGSwIy7Izzvp3kipOXd1+Fk73Cw28O0R9T?=
 =?us-ascii?Q?b/MAq9iBm2s2pj701PNpjcpY0I7e/DMdQ1M3jY5DbV5OT7KvfAgfkPD0+UIk?=
 =?us-ascii?Q?pBW9EY5AY0TY3gPrbS5LXEBzKWezIXK5DfyaWVYnCC8AVc+Mvk/tIPYyhOWM?=
 =?us-ascii?Q?ZI6/vbFzcohezCViwhS1dgcYuqOkxpQORR+sgecN04osem2BlQ9EQBJcwjwB?=
 =?us-ascii?Q?Q1+JB+qt+d1ZcryYfw/bvBag2hjwCSO4e2qsdD7zDb9IsnCVphgb34/PD76z?=
 =?us-ascii?Q?fXisRCx14tY8E0+DresKukwvt4EDgI4zrFEC8kI2RJ6TfUF0ypjm8BQIdBv2?=
 =?us-ascii?Q?Oa3NCIzgLQ7UDK4eypBBsWRtPHHae5SFU7nnZoDfigG5352zJx7xuLP1WToj?=
 =?us-ascii?Q?aXAiF01el7Q8t2XLdhs6vTvJQlH8jqjdKQ+23gRYx67g4XNAcPBYbqYMBo8V?=
 =?us-ascii?Q?En3yr5SO2/VkGUxwkwaW5qEiYj8UtkbO5ekS9E0AxGUptZy91mxBW7o8q1Vs?=
 =?us-ascii?Q?MWo3vX0DryWS/DMNAdEHRwiGWVObmLXBpJbojHTzMODp9/Bu5ZJrmkHqqUvp?=
 =?us-ascii?Q?vZ6jouUZALxpT1cqfCVPFrFcF7BVAZUmusDBFTW32/MVGyUYQxt87WeV9ji0?=
 =?us-ascii?Q?+L/skf+8oPK4om20dw359SWaF+BkmcJB6Hu/RBjfocLjpW8nwaJ8Q=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;6:odemh9C/UX9OEKf9OXRhxFn5Mng1xeGFG15Q5Z6I2SXW6pWvPm2DpXPkmHuoEwoq/8L8KVaqb0Ph4hrBSz8Dfiib68D/fZ6yOMdOBnFutgrh3T8p3Cv5C61eg+l2zxY5Dzxy8NB4R3t3dQJDnQYwQKMBjXWwbnlXevbu/1tQsbI3sj/f+RnSDj95LeUIFJphQGl5Eaob2Z8jyz03UtS9JGaxi+2qkMj18KJEb9c3HN+F2L9ovUG+UgCtlzqlfkngvxJ8RDYCpY5+PNxYtWdmx0v8OB2u7pua9bahV0QJDY8Oalaer81ZmrEeRKUqYPo2JYnGJuhqtsB7HJBmjmUg/RIQM2F5EpV0Vd10Lr0Hu6M=;5:+U0v+B+GGxeSwbRxfjkFu3U6tLThjqH1N/SNfC32W1VzLftFHwJxnopSDDEB4eoEekK3a6yXOIX7YAygeU9J/T4pu9EzWTHfoEk5+p+VVTir3bCiAHMeSn1GB0ZrXiQRuMKwjXE0EhKps+2t/9GQlxL8i/qAj/WeCgf/tWyLaiU=;24:TyIbOTyahGhaXGPYudgwxlfgRXn5ZqNLxiqOX4ouccbT+/EdwooAdz/nfRnpH05S1tr5zm6NDJIpVTxdGYXUqJiFpa5AAcqcGpPKC5tru3Q=;7:2KPMRkcjosR6UEpAuDjjPcwJnMGYxfis2YbTX7t5679C8jg4Wh43s1rPtcOzoaRdOlZEpApEaHZXbalDFK2MYCueoaTdCGltogdftDsSbS6r+N4nLyxmbguVHpogU01+zu5ZR+2fl9DUfbwcd0gj+t8Fc9v1auqPHVsE/v+FxSEvfHQK5spqLpUPCV06fNsghDl4I8zRF61zFnzseraTLBjxL9/MxzSX17WkX8UlG5ciCcODwSxmKflJwbjQ2ZSm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;20:TqD7sQY4Llik5KpqP6moVuuD+4Kg48HzhgT/J9OG4MY6roZA/YDDxme4BdArxEezhDhzcXa/RdIBR9uLUMQgjSOCMNEg1yd1WQjHX2mv6GofJ6YDdCVxWiUQI8JCuBFnPRPv1s4xsouyqD7xkGYG343+PO8vS+Z9qucn+/Abc5PDrsLmYPaoNC63WdNB/39U2mVPvAFw+dx7XRUHBpT0j8vTPck+2s3SOaxioBWF/BQVv3ykdNo05+fVKkBmFxuO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 18:48:26.3850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fc432e-d86a-4ac5-356a-08d569a46121
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1907
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Pass the bank number to smca_get_bank_type() since that's all we need.

Also, we should compare the bank number to the size of the smca_banks
array not the number of bank types. Bank types are reused for multiple
banks, so the number of types can be different from the number of banks
in a system. We could return an invalid bank type.

Use smca_get_bank_type() in get_name(), and change type of bank_type
variable to match return type of smca_get_bank_type().

Cc: <stable@vger.kernel.org> # 4.14.x: 11cf887728a3 x86/MCE/AMD: Define a function to get SMCA bank type
Cc: <stable@vger.kernel.org> # 4.14.x: c6708d50f166 x86/MCE: Report only DRAM ECC as memory errors on AMD systems
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index 0f32ad242324..4e16afc0794d 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -110,14 +110,14 @@ const char *smca_get_long_name(enum smca_bank_types t)
 }
 EXPORT_SYMBOL_GPL(smca_get_long_name);
 
-static enum smca_bank_types smca_get_bank_type(struct mce *m)
+static enum smca_bank_types smca_get_bank_type(unsigned int bank)
 {
 	struct smca_bank *b;
 
-	if (m->bank >= N_SMCA_BANK_TYPES)
+	if (bank >= ARRAY_SIZE(smca_banks))
 		return N_SMCA_BANK_TYPES;
 
-	b = &smca_banks[m->bank];
+	b = &smca_banks[bank];
 	if (!b->hwid)
 		return N_SMCA_BANK_TYPES;
 
@@ -760,7 +760,7 @@ bool amd_mce_is_memory_error(struct mce *m)
 	u8 xec = (m->status >> 16) & 0x1f;
 
 	if (mce_flags.smca)
-		return smca_get_bank_type(m) == SMCA_UMC && xec == 0x0;
+		return smca_get_bank_type(m->bank) == SMCA_UMC && xec == 0x0;
 
 	return m->bank == 4 && xec == 0x8;
 }
@@ -1063,7 +1063,7 @@ static struct kobj_type threshold_ktype = {
 
 static const char *get_name(unsigned int bank, struct threshold_block *b)
 {
-	unsigned int bank_type;
+	enum smca_bank_types bank_type;
 
 	if (!mce_flags.smca) {
 		if (b && bank == 4)
@@ -1072,11 +1072,10 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 		return th_names[bank];
 	}
 
-	if (!smca_banks[bank].hwid)
+	bank_type = smca_get_bank_type(bank);
+	if (bank_type >= N_SMCA_BANK_TYPES)
 		return NULL;
 
-	bank_type = smca_banks[bank].hwid->bank_type;
-
 	if (b && bank_type == SMCA_UMC) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];
-- 
2.14.1
