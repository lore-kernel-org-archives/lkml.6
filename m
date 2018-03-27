Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeC0PIC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:08:02 -0400
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:25088
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752686AbeC0PH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:07:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH 6/7] net: thunderx: add workqueue control structures for handle ndo_set_rx_mode request
Date: Tue, 27 Mar 2018 08:07:35 -0700
Message-Id: <20180327150736.10718-7-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:3:93::13) To CY4PR07MB2998.namprd07.prod.outlook.com
 (2603:10b6:903:d0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0e9e9aa-8d7c-4fdf-7aa8-08d593f48389
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2998;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;3:uDOpFYeVO0GCXXycxuYOc9NiBjbMzoU1U/S+oFMLzETHlyy9LRg1ScXWVbMD62071ZD79tOFCqKHaPrbJykt/GO7HqtA1bh/l0UnQxIDYO8EMAJ8I9sMjUKJNJTHPAVF5bWXzmIZK7xyL00whqDb9t3CgWevopfAvIeu2xknQ2hZ5UZchuCQY2m/l6bnq/jtS/EjZPyyAx95adOGi1Mzc01H32ScvmIzneNN6E65FT+TQVRr3ZqGqIlLok+sO1Bs;25:DyDDoz7v1gpE7FJzqKpK+RIlLKkJJn4ynZqtwobi8JgJXfmsi5+aVF/lAwNVdJYnApjZFIc94NrKz3sqhZJMnjdK1+IkQSq94bSHpQecNe2KcOY73crO1s8EVb1xg9rOhwVybVclfSZwtJ6qLeOX8eeCN3dTWIKJ3fQxX2Kp+GlhrdM5jYqj/HSbgmlf69CVU2B4LK7Rbq2pjOnrnIWT8pSHK+9gTsjl4Xql+MC08rNZImeLzrpIFyTOt+o5iztShuXbQtxBNWavzgnfNRezMH761rKiqp6s22dSOY+ba4dq/nU8WIQuNBNeZpxirWw7hs9vCCRdiPPd4nLDNcKeSA==;31:VjEoHxHyhwlGWD54BgNHNr51jFEGW7wvz28EZSPcwhQTbgD9zPXKapGY0QoxP3bdLOMaJQlhqD0Ndhey28b/6WajOWo0TXQdY8D2iCx8q60/gVdVCT1WtewL2/UX613OyIhN8/SGpil/FlGm20sVhLiRYn7QQ5MQl/+Pt74cNX6EutOl2tVAMmg8xpnJPHUFqnHZ7p8LCwe1QwE8RtA90TlMp5vV44a37KfcjN6rBSA=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2998:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;20:tA5FcI2FwUtFf0aoLrdq8R4VHcEN5Su1I3VTpv2Wcx2fVgAHkF20upH1sBDnYPnh6VVmH2xq7x8GaIZtD5ZgoG1hw5g4CaxHf7jwEY3vUly4AEdVfiFDBpGOsw1aP4TSx4TIO3bnWME/14jL3w3dqRpJrEhZMwB/OyHK3DjbArgV3Yybx7odhuzx/dt45km8bQur9phMxIeU2G42Dakb6DJpLY6Vijl5xQ6pw9E5RCQyhY+G+P/CaYMIUWjgZndWVIsHNv0bqYrcCcJORz8cn2s/ixGOv7jN7rsbFqkynWpZZrrkldfUq3WFSQ2W5J6da/b9kSvkhXhDcmJj33lIqe51zPGxDKQJkJxeKzRP0O94wzCvs7UJFM4p57/dgFZYN4Pzfwje3xxfHyR0rbjTv8LIvJvkPYOTqHBY8E5/SwWMfE+0bLnL7bao5OXxGZ8p/B7pWVexl+PfzlrnRzR3ZvrUKik+B/7KuBB4mbjdcfmRCyJZnLn+dSLCE1O48t4YEckEzavpNr12q27eD/nA3CgzAhZ9MNRDPbFzwZsy2yAndbG8dXyN7Mgf1ZNMYRngFVoiisExWqSccfG+x3jH5QzjYMQCkNLi+inKugWkC5M=;4:TIAwF0DEw2Q5Jad+LZkgDwQy2rzZbgSwgqrl195GgkkHO0WHx55gQGxknu743V7UiguNzQs2vmviDCSybMZYhcj3oK2ISUl7bU9Ee7L410g89KPpJmCvD2qnRFPnGMW2X8ecJlsrYah3bd4tVaXKRiSBiQYBC6yjA+uLTxhBkx5YOpjcBlI+82mznLa2U0iWQe/ZfCQtO7xauTJ3VUQ3fQ5yN4UmGMNmHxh9e0kTHcyVbYDnR3zfxyf+IJIOQ9nIUPFBQVMH9FladEqHO45R3g==
X-Microsoft-Antispam-PRVS: <CY4PR07MB29989C277ADB648399A76F5F8AAC0@CY4PR07MB2998.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2998;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2998;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(189003)(199004)(446003)(2616005)(6116002)(478600001)(1076002)(107886003)(3846002)(6666003)(956004)(97736004)(39060400002)(50466002)(7736002)(53936002)(16526019)(66066001)(47776003)(26005)(486005)(486005)(6486002)(6512007)(316002)(305945005)(11346002)(105586002)(42882007)(6506007)(386003)(68736007)(59450400001)(69596002)(106356001)(72206003)(25786009)(2906002)(52116002)(53416004)(76176011)(81166006)(8676002)(36756003)(476003)(2870700001)(50226002)(4326008)(5660300001)(81156014)(23676004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2998;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIyOTk4OzIzOkc0QVVKMk9LaFhGS2ZTclFGWkpjaWU0MUoz?=
 =?utf-8?B?enZVUGkxSkE3OTFHcUtaRURVdlpZbkFtRnZHZE10TzF5Vk8wWkk3WTFRb1M3?=
 =?utf-8?B?QjdjOFh1SXBHMGpnSnV5d01FdkhmbDl3eCtzZWxMMTJOMzVtZndzK3hzTG10?=
 =?utf-8?B?T25ETEtwc2F6M2xXM2tVZ3Axa1o0cWFKN0traXcvbXJwcDFMU0lWcmRzaFVX?=
 =?utf-8?B?WWZjQ1hrTHhhTm51RFVmaXREeUE3VGNlOEFxeEl2Y0huYWNuRUhGc1BWYUFj?=
 =?utf-8?B?cDlZbVdDT25ZblV3ZzRsVXRMRllXbmlUNUNvQXBKRlF4YWx2YWpGTEV4U1c0?=
 =?utf-8?B?N1grRm5UTDN5dVpaVnVRczZ4ZWh3UTlUMEtET3dyck11K2xwNWQrdWM0WDNO?=
 =?utf-8?B?b2lROFhlWGwvTkJYdHhIc01WL000Wi9GWjEwbzBVQkVXTXpNWWNyc08ycG04?=
 =?utf-8?B?UVRVSElCWkViQ2w5RldxV0lid0pubFVMZDFGbklJQW9DUElWRkpnZ1o4T3o0?=
 =?utf-8?B?MW8vUExMcUF5NDNoWHluc2VMWkJUU1Z1RGNyTG9uN0lONnMzSVUwZ2N6eXhy?=
 =?utf-8?B?U0VvWmdrU0hUYjJ1a3Z3bHVpQ00wNy9adFkxSzlJTXpwUXpOR0JqTHVvTDdW?=
 =?utf-8?B?dFdhdFIvakVPaHlMcmd3cGo0RW9OeWFkNE5mWHNaUG1UWnF3VWoxNjVwRjlH?=
 =?utf-8?B?MU5NYXR6MTNVQmtVTDJNUTJ5QlVCZjhHbXBMdmpnanN1eXErSlRSM1dTM1NE?=
 =?utf-8?B?NS9lZTBKNnhJWTFPNXYxVG95dWN5Ty9sbjZrNTVvSFljNnVpQWd2VCtVS0Ir?=
 =?utf-8?B?U0ZRdU9rampMcExIdWdoNUxoNEF5dDZ6V2I4SmR3QWZKaU8zenZTOVhTTDZZ?=
 =?utf-8?B?TFRwWjZESFcxOUJmSVoybmw4Y2hFd0Z3K0tkZUFLRCtzaGNZeUVuTkdHblJW?=
 =?utf-8?B?YVAvSlhsdVNUdTExczZ1RkFvWThDRGU4L0hVdDd1UER5VE9hS2dFQW9oeFBU?=
 =?utf-8?B?dFkvZnIySzVVOWN4Zjg0citNK2dTU3lrWDBRdnBIQ3ptYWF0cUxHcjBZWDZ2?=
 =?utf-8?B?d0dWYmhEK2pXMzdqQ21VVVUyMW9hVmV1OG5UUFRGUnlhMmxDc2c1MnJsTjFW?=
 =?utf-8?B?dVI4VjB4ZGQvTWJnTzM2a25KbmhZR3ZVd3QwVGVIUytqL1o5NEcxakQwSlg3?=
 =?utf-8?B?NDNiQkNQbVdYTGRBTWhLT2FyOWZsOTRBRHZ1UkVyNVR0cUFXZmZnd2pQdk91?=
 =?utf-8?B?WUhUOFNYTTRSczFCcHJvQnN3NEJFSXJ2Q1JFNllzTGNOQ1I1S3pXU0Y2SmJQ?=
 =?utf-8?B?blVuMWpIYWNTNGFUcE9kRS9XcDJTdlFrQW1pam5sUU15bThlZmIzZkFicDl2?=
 =?utf-8?B?akpDU0FJcmRqc3NrTWtCVEppRWJuaUovY1lhRFQycFVldncwQkIrdlhYdG5X?=
 =?utf-8?B?a2poSXVWK25ab1B0Rm0vY1BPUmpWM2JyK3M1bVQ0RmQ2RE1oMnpNeUU3dnVs?=
 =?utf-8?B?YmtxZDkyV09tVm9TdkZuRklPbVVZODBEOVRpR0dEd0FsbGVkdU5JV3dYd3E5?=
 =?utf-8?B?N3B1NDNjQzhHcTBJaTFmcnk0dkRPSngxZjdIWTFtakw5YURpK3pPRG5qRGw3?=
 =?utf-8?B?L2MwL3daVWtZNFJUUWhVUVFmZy9kaXJMenZxZWJJekdzWVh0V25MUlVMV0dM?=
 =?utf-8?B?SVcrcGJKL2tlYWhVNE4xMGkrVFhoc0dDTU43SjFsMUE2TUJxWEx1Ty90REll?=
 =?utf-8?Q?6nOfb3NtGFQ0GLls9JNR+GnJ2+V4r1SFPvqTI=3D?=
X-Microsoft-Antispam-Message-Info: I/Govw+cIVkeWxQTA3tnKerl5XTvu66KBjLW6Sx3XS7jHOhqHGs3kc/hlG4HTHembiiPMxUvh9yjcpY04+1uwyGwkX0cWV2zJb6qhw930A/+hwXqloAKGphcXTA7DdgKiyI595cEWEPWd/ydWUCAlXNY/Ry+OXALZXEAX77S7SN0XhFGw/wC99rRSayFLmex
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;6:Mb0TrQJievb6SZqh8iKGH5da/hlBHowOWi8fMXKlRGQ1MmRAOXIBdeD925BSnw29+PrT9QHejHOUaK7BTZGxQ5eIVeZOEn3vg9rfM8t1mDAD/59nUYz+XoVjsnsGBILyOeFSy7YEwJbrSo7/hZNdmygzuSbMi9ZgmAi4SwqMCnFupbPTIlAvMfIqliMKlJ49FPRdrlDWPC1/2yNohH+K0U5Wji3quN5myMRMvMyaK2j/gnIaAfpZwafvUbvyhd9FF8LPv8HiP7nVN/rk1uyJvmZV9qBGbQALpUZQA7Sb5luFs9YQp8LdkTqj0KFyaIT7uwKel8MKnPYyNiXB1zP1YNiF2YkPZm1AMD6QhLHQoij89H5IOD2u8yhTSmEgMTo/swsebu+6E89nn6FGGdD+I/9X56tUMfIPxbUkUfqgw7CNko1PouNrxLLe6aFtfMpIoD3njKlRM2tH4CA7WaD24g==;5:LFKrTjeZVsMlIWig3vf0xBwFXRMWpuYM5dFTDzK7CAFeaOnewjkWn43d2eLc6zYz1RmrgkVe7pop69zkvJY8VFfG++o2XP8QkmhCku9HJg+LmiqstNXFKSZuel2bxINfQ+LbRPakha3/21Z6FOQgeRDWYeQ72qRRfIG67y6Ev+c=;24:mSNhl9t1T3NB0OM+o+0BeAwqkZX/JJOHqgGBKtW/l7Vg6TCIEgWY/4P0BpZrdQkbFHbkVMJV/+HFmpLhq2AhtvxtYodwwIq44+mAkTU98Xw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;7:e5U6kR4Xfy5BNAyCo7cqLapJ8bqK2f3oPCcu4HtRuhXibHPyafVZ9ZGeT1VaBpQisg3g94IX6J8V1JNkQImKCb6PKAfGSd8xkoESUdFzcL2D+5/7+bPKIjH76UDpI36plc4rbtU3GFVHkQG4sywFe8frWvPOgaoxsIcQmWUcZK+TKRmlyE6vOkPyUqwrGVljxLYaPJCGQFEKszQDipGS1JP/wkkdI2oqr0RwDwtmXYSNJE8DYeI4KfdsNHV5Bgbf
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 15:07:52.4671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e9e9aa-8d7c-4fdf-7aa8-08d593f48389
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2998
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The kernel calls ndo_set_rx_mode() callback from atomic context which
causes messaging timeouts between VF and PF (as they’re implemented
via MSIx). So in order to handle ndo_set_rx_mode() we need to get rid of it.

This commit implements necessary workqueue related structures to let VF
queue kernel request processing in non-atomic context later.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 069289b4f968..5fc46c5a4f36 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -265,6 +265,22 @@ struct nicvf_drv_stats {
 
 struct cavium_ptp;
 
+struct xcast_addr {
+	struct list_head list;
+	u64              addr;
+};
+
+struct xcast_addr_list {
+	struct list_head list;
+	int              count;
+};
+
+struct nicvf_work {
+	struct delayed_work    work;
+	u8                     mode;
+	struct xcast_addr_list *mc;
+};
+
 struct nicvf {
 	struct nicvf		*pnicvf;
 	struct net_device	*netdev;
@@ -313,6 +329,7 @@ struct nicvf {
 	struct nicvf_pfc	pfc;
 	struct tasklet_struct	qs_err_task;
 	struct work_struct	reset_task;
+	struct nicvf_work       rx_mode_work;
 
 	/* PTP timestamp */
 	struct cavium_ptp	*ptp_clock;
-- 
2.14.3
