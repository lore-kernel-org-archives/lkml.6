Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeC3MAk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:00:40 -0400
Received: from mail-sn1nam02on0086.outbound.protection.outlook.com ([104.47.36.86]:55618
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752455AbeC3MAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:00:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, ynorov@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v2 6/7] net: thunderx: add workqueue control structures for handle ndo_set_rx_mode request
Date: Fri, 30 Mar 2018 04:59:52 -0700
Message-Id: <20180330115953.17154-7-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:102:1::16) To CY4PR07MB2997.namprd07.prod.outlook.com
 (2603:10b6:903:d0::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec10399c-7684-4c36-8ed1-08d59635d74f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2997;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;3:RbIKYwFT+l5scRX/YFFP7SbyuAOoWEgbq0AbcMybJ4q+aD99R+yHSb5CarI0CI6tM6/9WCWGuOr8RYj4PUJMRQs2/85uwnGs/ftdhoBCGuqeqQDNgV7kE5NjAnQHevtsDcHIb2Pbm7ItOb/VSsO10qmO1xozbBf0qBF3WiHJ0AKh+UmkdW+Ff36Rizmju4Fbhmq2zv+EyxE/w0fdJCvwlyYzb9PlG/Cc0/jEuRtoTJfYImWFeb8smSQnaIdfJzKi;25:cCUC5shM9b2IG1QWv4q1YIb7XYgEvDvCxO7DilOF+mR0mFrONmFyPuHlOJUVi4Q5B+o0t7IBzfwCHE0EoT//XQp/H7PmMCBbiSN9wrcSFksXKqExWgnVPynnEKnZGQ79FtD6PtLPY0R+t0BIsGM/0tB8SaSZWULwcPL4lrBsY2yTV5fpXUsAW1pt4sPnsDPIYta6GGn1DUulWQsoQ7/HynXL/P837zp6MJ6zqc2ZpaWbvfLl0yNy9lTy3WyklS1AxsPsI0bnvN1TWlbyeEw2jP5bFHo+PezOqMFaam/lhiwQhZ0XQ6WmDJsfBTvqOBw7eONhiCeYuV/oZrbVjEGeKw==;31:WPQ3jf6VhYj/rKJqz7OgtFiADLYp8zLyIJ8CTUXmU/ct8yZ3lMOOrvHTLD8wlWThucbRbV1NJE3x5YpJ2oGYpYqVjax4NcFTVf16BaCP1BjbAHbEQ+FNEGLN6y9eplvSZKUQmJ5VBfMVU9uJNHBuQ8mUZQyyx7a+oYo32v7pxLlGRk1kmZkeK1B1zFYB5oUCYRLVLPksPbumENFZVXBqux4i/8ObYSo4DPrE9u2Y6a4=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2997:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;20:u7epodgzBTs2ALY3Ui72JUJ8QAzD1pj5buy7yEztBfE72kgZ/H/D6x+XTBEtZMnJcpdJAiQzh+55o5h6UUaOX4/AB8SVhLbl3sWniFirjRN1SUhdDXdU8KGzXBzK0jDY20rj4V8c61i5ksI0QklSYHr6dUn07ip26Fh5Ujug+vMDRw3V8x+ilHK4G+Xs5drGw3Ud2OOWkp1rLGWow6diF1wGcnra49+G1wI5DaI1nwvwGq8h/U6UNo2fHuu9Xgs2xQqYgl3kZMW5QI1j1Gi4EUxZh7Yby6tza3xPIe60XMU/Bxeh++L5J0JJe8gIsgQEw+VmJDQCuq3XD4RU4su0GHoKb6IkDeoQnw47FCxKpVtmm60yjr+BqtS+8XkcKsyGMFNfCxx6uznbjyEqzWBZvT5YGfU8nNdiTaBn+H2Ah+w5nm0A3t7ivAjR01J30QX1hY0PG8l2/hcEYS17J6jk19hNnDB5rk4gYBHgU85PhowGZn+LnnFu62qAXnXmpNFGDV8BQrFa424+aAo8pLDyIWLhw1jahBizhicB2bfqV0PQ92j5vTDZjfgN2etLRd/zua0YdTpZiLVt/CgjvijU610ZSs5iUHNX5RQfRKMWLRQ=;4:jQG/mAwaRNbqAiZj7TM9u411ho74oH/0xfSoCGCMo1TyL/tXWn5WR3tIUVkUo77pmroA5jRhf4+bKahZLkbqE0LgPMOIzWG1A0DSIQeLGr9ZEmwnv/dAU8roVyhH/mclEORBiYXP4UsvRHhL+nGdDQRl6VhUiZtWB3pmpAPgZXAyqjvYNqp1hZ96K8Vx8uvfT0PuawSKkrQLVX55eNvIqle+hAeOwLrnESmE6qijxFhIWCRQ4Nd5inl8XiOD/GDai88VAIbdlcsSe+73mU5fWg==
X-Microsoft-Antispam-PRVS: <CY4PR07MB29974EFC2A160D47EE43F83B8AA10@CY4PR07MB2997.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2997;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2997;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(39380400002)(346002)(366004)(39850400004)(189003)(199004)(3846002)(6116002)(1076002)(105586002)(81156014)(81166006)(8676002)(50466002)(53416004)(5660300001)(52116002)(97736004)(23676004)(6506007)(8936002)(59450400001)(76176011)(386003)(69596002)(2906002)(6486002)(6512007)(72206003)(39060400002)(6666003)(47776003)(316002)(7736002)(106356001)(486005)(486005)(476003)(107886003)(446003)(305945005)(53936002)(11346002)(2616005)(66066001)(16526019)(956004)(478600001)(68736007)(36756003)(50226002)(26005)(4326008)(2870700001)(42882007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2997;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIyOTk3OzIzOjIyYzg2Tlc5bFR1Y245bnBpbk5TMUQ4eXRL?=
 =?utf-8?B?ZGRhWmVpUDMyRmFHSXRHdXY2NFNIZ0hBMDFoR1Z4dWkxRDJCZDZ0VGFCQjhq?=
 =?utf-8?B?TVY1WVBiZHArN21sTktjLzF0c0V0U0ZzekpoMThuNFlDOEc2T2V6YVp1WjF1?=
 =?utf-8?B?dGZmLzFZUlpEb3prdTcrL2NHNnlPMTVwRlNBT25pYWRaeG0rbStBeTZwQk8r?=
 =?utf-8?B?bk5QZ2JFZC8zNE1ENGszM3NsL21NK2N0a241L2FmUzQwZW5HbERDSDFFQUxs?=
 =?utf-8?B?RmJid0ZOTHZZZ1VqenkzWFhRMk5sL2FQVEcvT0xUK1crRU80b08xeXh6NHhh?=
 =?utf-8?B?WnJwR25mV2ljOVhsVEFnVmQ4aER0Nzg5a2wvV1lvdzJiYU1sTXpjMlR5SENE?=
 =?utf-8?B?S08yc29VN2dZbFBrcE53WUxqNHN3VGVqV3kxaFlUSnU4VFpxMGZWREVCLy9B?=
 =?utf-8?B?WE5VL0Z4MEhzZXdaUzBWczU1NGpWaEZkaWVCWGdqM1pZUFB0bzN6enIwb2Zk?=
 =?utf-8?B?VVo2MmRQek1jZ09xVThzUDRWWEgxMTN6ek54ZkN5Y01veUlDMHU5ODQ4ajBl?=
 =?utf-8?B?bFZERFRnVVQvQXphUXg3ZC93cW5vU3JsM0QvZldMZllYRENoYUkvamdYL2dQ?=
 =?utf-8?B?YVF1RDZZc0ZIV1lxdjM2bmJLcGV2MWJVdTFaTHRUa1YwYitJL2NadlU5TE1C?=
 =?utf-8?B?ZTNPREp0SDJBVFV1K0xTSXpZdEpMYW9PeWZYRjZvUGU4OXc3bzJNcHRCZnlY?=
 =?utf-8?B?bGNsZGw1VGdKV0FQcTBCZEVCblpvSEFwZ3BkZTBMTU9seDJSdTRBQkVCTGxB?=
 =?utf-8?B?cGR2dk93SjhKaXlxV3V6UElwbk9hbTllSDR1NksrcjBmV1JPTTlpQkk5R2V3?=
 =?utf-8?B?VzNuZ2ExK3g0Qm1LZHJRZElSaGM2NjRSc1M5TEpvdUNqaXUrU3RZdk1ZemhP?=
 =?utf-8?B?alo4VmNkdG9uNkMvakIrdklieVhjNlFRallSN084R2ZwVTBNa2dYMHZUR3Bn?=
 =?utf-8?B?S2pkb0I4N1JMc2lBN29MWFhsZXcrMFllazVybEcwVVdKVEZmWjZsdTBIZXBG?=
 =?utf-8?B?eE5SZHcxQVFRSC9EOC9ndkQwTlMreGhOc25NUnU1UTI5UG9UeHNJa3FDMVdQ?=
 =?utf-8?B?bkhOQlN3emI5QlpJTnZiTTFJcW9hU2JtVmU3T2x2QlUwdUFaVjYyRUc1dXpB?=
 =?utf-8?B?NCtUOHR3ZE12SGhSdGxTNEJtMTFqUlVFV2VjWXowL280USs0Sm85SWxCUll2?=
 =?utf-8?B?RWJTek4rRmJHUDAxdnFmMGxjeVZXb3BnS1JtWXl5SDhiSXZza1FrTGo1a2Fl?=
 =?utf-8?B?RE1vQ1hqWmZPZi9Fb2N0WmVaQW9TMlo4Z2REaWR5elM0SmNvSi8weFNWdVVM?=
 =?utf-8?B?NFBoOTVtWGExeVNXeDFjV3A3Y1Y4U1I0WFlZNTJQc0NzQUhvN3c1Nnora2dP?=
 =?utf-8?B?NlhpeittNEM2YnM3ZU11ZWNxTWhHNTJ2MUZtT255TFMwdUViQmlrQ0oybzJO?=
 =?utf-8?B?QU9lSkQ3cVdweGhpUklDT0dia3VHY0dYRS8ySS9IQkFBbHlnQTR4eHkwWldR?=
 =?utf-8?B?YzRBMWs5U2pISVQ5NTBNNFJzY1MwRVQwRWxOQW8zMFZveGlUajZlWk0wZVgz?=
 =?utf-8?B?Y2t0NUNGZkQxTG1YeE1UNWZCN1poOGEvaTY2eXhmcGM2SUU3SU85U0h6cmc0?=
 =?utf-8?B?Nmk4d0ZTckNxMWp1WjMxSDA2VTVSY01ic3BnY0ZuRCt1SGoyWXhjVWo4cjhL?=
 =?utf-8?Q?jkJJTyxqOp1XRJMpJcKLlE6IaZWDQy/oQxeYc=3D?=
X-Microsoft-Antispam-Message-Info: c1GyIlKqiRDEosy4bDFQBankWAAF0bz5fnAH2OEVEAjwGmIBkbVEQi5lMMrBYLOYI4QPqXHunniG19NVYwD59PIjj4E6QrtZRw4px5Ze2IA66iJ3b6l07itj7799EZHPDEnMrJwFkohMmBKlaOKbAhnjo3mSgCTN4JhRLly7uk7NNViA2O/1J+1CxuVk5IMh
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;6:vX/JR4Kc6DzVLiEaxJ2nB/o2vmUhR5z6ba+C6uu6BHomH/qN8ZDRY6NhIx9Om0XcEFkk1F9rvAUsXB6bkJeLiIRrURrr2sCHoPgsWkruesfxhvwj9vGIj2wJButn/QW5T/Yvbo9biSOCgD3KslRlO1fyVf8GFu5raOtpn4XymFsqXyq3Xr0A3eQnxqqGRtx88HFsjg2RdtmBff4uFxZypq0GzK0jkNLjEzvd+KpMyMEnaCqNd+RBBkSyUhHPkGruhLqXIVKZGXGmjWErBTx4kTUdo+uxds/8j/oeGaUQJlReJxMSodoxBit+vLMRmAujGa5nsLRb4DFe1Wq77Z1EjwPJa17ERZHhC/4ax0mXmuc8s8D7F/DXwMNFQhJIsIV7EKIGdvpgEGUeG0XHSfQjdkacMm8YlTfv3SSCt5y8Q60dqPBdInTHwSSh6vtxGKG8yW9mRaLUPNz0e5pWPPxGRg==;5:WZf3YvcpQeP4yKwgfHypfKjS3oamNgD/VVmcFCh+8+pqBTTIBKdAFSb9TIETXMU4EExNRAXqk0ymCUao2VMfqkCahPPK74HaaAnOqEav9BF1+wA+bZ9VbmNQ64iTR5DldyK3qwMbWsmcW94VACxNhh62+IagevrT5T01pnk8Ldw=;24:iC790EQom9jUCiAK7+Y06AoXiMqLpzHP0hXtoaX8KCLWOeB0mYfT1w/qTw8wlFnijQfxQ6gYB/s/Jx8QB+RsUwEEt21twOnpJtWB1Bohu2U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;7:CPs4cBzgZExxxRNgcHIxgDnD1S8Zn/Xg4sW9b9QODNRct+ovszATPPDbvY5rPITcXLmDSoMu30WQ90wjW6zMFOsxlmWoRJbdqXBqfR3Hk+3FgjX0aSjFIy0aJHDjrvk7rWeL5he+RsiDhC6SCy38lfp+XR3toZ+tqKVykxb1YgiOqoIAkZ7sDhF3TSW+COPVb8Y6EKvPt2z6wodKOCdfW49A2FEqWx03tBloLHbT6W6OQG8hs/RZVBLNrg+IU3PX
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 12:00:32.6916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec10399c-7684-4c36-8ed1-08d59635d74f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2997
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The kernel calls ndo_set_rx_mode() callback from atomic context which
causes messaging timeouts between VF and PF (as they’re implemented via
MSIx). So in order to handle ndo_set_rx_mode() we need to get rid of it.

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
