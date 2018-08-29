Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B53C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9653320657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0PqTKMgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9653320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbeH2TbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:31:00 -0400
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:36496
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727484AbeH2TbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urIXld4wRpnyuxA6w1sbBBstB0/I2tgVUBCuOupsjqI=;
 b=0PqTKMgRBnJ4QSz/jLK0SXnjyqfD9FiEn3h3uteXjfbZ8ttWzYICMaYMN7g+Z3A15p98htbZsPSBnu5ojKSeSyPUS7UFdcLI4GAAXRqVaNLSEbwWF4VGFFPomr7iCYQErGO5rPMhIS0Qu/jFFEklhqIsddSEl6rrXY6HZIcg6+k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:6f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 15:33:27 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 2/3] x86/mm: add .data..decrypted section to hold
 shared variables
To:     Sean Christopherson <sean.j.christopherson@intel.com>
References: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
 <1535494377-25600-3-git-send-email-brijesh.singh@amd.com>
 <20180829150314.GA32493@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <0de361d4-1d1e-0584-f9d4-41bf5936e2be@amd.com>
Date:   Wed, 29 Aug 2018 10:33:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829150314.GA32493@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0114.namprd05.prod.outlook.com
 (2603:10b6:803:42::31) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:6f::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22bdbe50-df73-4246-39ab-08d60dc4c41a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2685;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;3:e8CZQp/0QPmDTIeNZgzKXVls4Ny3gN8IO7mGzvvJm4SpP7Rt3YhYPjd0gOJqdDI3/ZuTCvYDSAEibhJRc+MXqs7wTjkfzouftPLsIsJieBBWaCB7GYiCmK1iUi0i2yO4ZvuJFKnRyfK1BQSFNj/JZOM9ju7ZqqkIOXo4fGGfcxpwvWHMGBM5D9orF5r0aC7FehImqvo4hWdlmpd3UGDgjy5rwSuRrq+CnvObeFU+yrMgbwOCsbXaJeyeUrZOlR1O;25:FIX2O2yS5pevCNOYIYN03IPCeqIBQtVZrqKPiOBjHutMcM+2Q31NL/HiWrtw8SYBnNJ32ZX+jxZ9zMpBLssa/FmvPtCS2pyljEc1rCu+99jZVrfEEwA+3yorUjRnfSGlOj41YnhxKepH+dqmrWN/7//pO+1NIml6rQ/oPmZtygKUMnGzAEvnFxvZybB9b56sx4k3ROAYOTbLiEa+2jOvqr3rzNlqUlZw/RL3JCRh9yGBTUfHZVUoTzVOKSDNWUZ/+5nBzHCqXfF8zcRltOPR4bWkvh97SQjU3QMEqAUuB/6+JDEqcbAGnY6LxUPx/2Ys5v44tjGgqOlCsP8s9xk9MA==;31:MzRkYTne99wvztLCCLUextI6YnHWXlhJTmMxKBEotkvgQAG/bx49eA90OJASlVEWsm7ewgxwAO1S0ZB0ODuGskp/xKJYmPCjnBJre0iVHqEXgkgI+zXSct81gj8fRHscQWQoytHOoKz2VOXtu4RKDwwCPxFuX4vkqgVISp2l7gQxDP4poQtHgt2lVoKk2LuVgVg1D8z/Oe/QGnCFrQbacEor8ReOOyfFzOpJm4Ri5S4=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;20:qFsFKbqCIN3/DtAKD4vtPDBFRgfGIC2/Jx6dPUydDbXg2hdn2RcP60G9rE+dRabkdIF1M50PwN1urDbJASTQ2KvYQaKzQenk9PReFbnvtZulcAyLWA1gRO7qNb8CTLslhY/CZAiEyscsuQvoqjNzyDZwkd7wACwFLkSm1BqDMvGq/ekVYcwvhkYrPd0cjC5JM9VPzO2oH38i/u1vKL8312kXfLdWNZmY1tVSGF31xOdng/tBx3/LydS8TOUmOtJyKG4gdr7lYitnXrX17ysMQwhkgoWP9lFLTxja9HS1sMRXjXa/MAdBA+MTE5ACrUpYhLRNRUP31hlnDOrJZNoCbxkKq9b+jVej/638K9zZFMZNVLeaVsI0pPqRa+F84Jeezls5AlV8cpXNqHJMxBk3EH8xSeBsfMgh7nEf2dOwhrTggyzJwiayXsWHPKb8JKw53/S6hLHo58yIBNfs4Zw7kxYUqxE9xfalFUHbJ3kz3p3X4aOjsBdjFy/HvaYgyRUD;4:Cg7BBPWmhAbd6yYee0E2mRmqohUynd2Ym+TCqve3ARW5E6GboAYbq3xTBlApI3f58X/20jVqzHV1sSzNx2KTUWvWCvCUSQcscfYdD6lP/MV6hfA1z7PyKEyBdDtPmYHyy3eRa/0zbKobA1A8+ISFZZsa6zoY5F/tgipHtB7EPDnfglolL0kPSYCijboo1i5uWZysqsuClYzsBl9MxKd7gKX2mds+aZL7MiiIdhwosxVaqyEMF50I2JuZUoWIUpwrZ+Vrc+1lxC4qaR9cK0XrRM8DhUAyF2onNKqZMT8uruI5PJ2y5AvaViwepOvIJW3mririZDviOxnxWMzHikdu9IHPXEnpyfAuxPo6mbVqSEI=
X-Microsoft-Antispam-PRVS: <SN6PR12MB2685D0F8DB023C960E8263AFE5090@SN6PR12MB2685.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(100405760836317)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN6PR12MB2685;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2685;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(396003)(366004)(346002)(136003)(199004)(189003)(186003)(77096007)(16526019)(53936002)(31686004)(2906002)(105586002)(68736007)(3846002)(478600001)(106356001)(6246003)(97736004)(6116002)(230700001)(26005)(53546011)(65826007)(81166006)(7736002)(16576012)(54906003)(316002)(6916009)(76176011)(8936002)(7416002)(23676004)(58126008)(2486003)(386003)(476003)(44832011)(52116002)(52146003)(956004)(486006)(67846002)(36756003)(446003)(11346002)(2616005)(305945005)(8676002)(5660300001)(229853002)(64126003)(86362001)(50466002)(6486002)(25786009)(6666003)(81156014)(4326008)(66066001)(65806001)(65956001)(31696002)(47776003)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2685;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg1OzIzOjBqWFk0bndzK09EV1NsRzBKQUV1MEFVcVZm?=
 =?utf-8?B?ZGJwaXA1Tmo4OUY2dTA2Y3JDZ2QvQTNhdFh3MUN3R3hZWE43YWZvV1U3QVpp?=
 =?utf-8?B?dWMwZ0h0UjI2NG1KNlovYXNvRWt4OU1PYzJZaUtsRzR1ME42clE2S1NsbWk0?=
 =?utf-8?B?cWExbmVRTmhuczJPSFMxZUcxQUU1NnRMNXNVaDFjL3MvbHFrV0tLVTNuaEhz?=
 =?utf-8?B?THFlbkY5YmdmQ1NOYkF0UU5ETHFHUCtSelRBNGZtWTR6SFhqTDREMkRpY2FQ?=
 =?utf-8?B?dWlLQVF6VHJpeGpFdmpoSGlyczd3TWVoSVU2cSswMFo1RVBQakRTejg1UndD?=
 =?utf-8?B?d2NYanNpTXVWYWN6ZlBuaTFQbis3c2ZuaEJHb1NDZmtVdEc4a2J6T1JzcUZn?=
 =?utf-8?B?OHFPRjdENTJXMVNWQm5oN29LRFVwN0g0OUFKZWFzclZ3UHFMVEtNMGxXRUlu?=
 =?utf-8?B?S3hDK3E1R1lUN0Fzdk11VS8rZnV4UWdJdkhnZmptM0RnSmkzRXduTzhtOEtU?=
 =?utf-8?B?R0hEVjZkMHE3ck5TeXBrL056eDF6UFo1NW81T3p6MS84QjZUb29EVWdsSzVl?=
 =?utf-8?B?NTNWSHBUNWJSeTdzZFdVSVhYRTladHB4V2VzclRHdnNtM1lJZUxQRHpMU1Vy?=
 =?utf-8?B?RTQ1c3ZCVEgzQUxtUXRCS3djNUM3aXZzaDFhL2ZOaHBUeGhtd2hYZDRzU3o3?=
 =?utf-8?B?UzNTTGFTSmlmR05BK3V4Ym52R28zY1BEdHVRUFY3elZkWlNob21McUR0dXpa?=
 =?utf-8?B?Sk8zSW9BU0NvdEd0WjN6c1lSdUpmYVNoeFVUb1V6T1F2QTdoNzQ0SU54TEY0?=
 =?utf-8?B?My9ERXU1ZDZoTXpvNjlrOHRtcmZtWGFNNG5KbklkYTRRakk5VFkwUTMwWWxi?=
 =?utf-8?B?akY0c0xKNVdoT25MNWsvVjl1S3A0dEt6aVJzMDJnR1NGR21ac3N3MHBLTE51?=
 =?utf-8?B?RUo1dzAreFdEYkNIbEpnamRGVXAvT21QZmx6OXpqNzY4K3RPNXBLbXlhOHk1?=
 =?utf-8?B?RmFhdnhoVDdXeWFQeFNVdGplU2JBemU1Y3RhVkZEZy9aMDJoN2FVd2pKaGxE?=
 =?utf-8?B?OHR1aXdWUk1vblpOcS9zZUl2TVdvUWtONWYwaEFhMzVkanFwdmwzeGVYZmE1?=
 =?utf-8?B?Yy9NVy9xNVkzTk94WVIwaG4rRUVuVmUzeE1WYW1GR0R1QXdlWUh0MDV4N2ZW?=
 =?utf-8?B?bVlMVC9GNzBac0tTbUI5RXhIMVUzK21BWjcyb1NRMG1zZGc3bUdadVZ1UElH?=
 =?utf-8?B?VkJBZEJDcDRZVzRVSkQveFpEV0RPaUs0bER1dkJISDJDbWUwRlZXY21UQStF?=
 =?utf-8?B?YVZ2SzVicWMxS3VvRHVqTnUvNkNjRUV1YVJrdE1KUEhlUE40YnlLNGpmRGEy?=
 =?utf-8?B?TjV2L0gvU1A4ay8zbXJua2c4V2xxQkRNNW9SeGpuUEdMRWRtVEUwTlZJWWxQ?=
 =?utf-8?B?OEFBdzVEendkOHR1VkJMWXI4aFlCUFNaNGVDUTl4Mk0xSzZqSGE0MEhCMW5F?=
 =?utf-8?B?OFBhaG1tTWd1dWtjRlY3SjdyNkJjTGhYL2VaY3ZxYVJKR0ViMjg4RmVxN3lV?=
 =?utf-8?B?VkNWeE15WnBqQllSVkR5b0svUDRVbEhocUw1RlpWZnZiU3BkZmtHZkxqbzlH?=
 =?utf-8?B?KytabDhtWXZCbDd0V0dUNFJqdWMvS3JhZ3Z4cGRDNFAxcytkdlBlaEQ3ZUpF?=
 =?utf-8?B?NU4xTEJ4Z1dlYWtuVTQvdU1BNDJmenpFU1RpUzJFMUkyN0JBZXM3bFpxdHZP?=
 =?utf-8?B?NjhpZEtZQ21PbFNoaEwwK1NKeDBwdjBQa2dlQUpaRnh4R2trdVJJY0p4dXM3?=
 =?utf-8?B?eVV3RnNCci9pejNYOE1Ec002dWt6VDE4YUhNZ2p2V0N0SU1uLzNXWGMzUi9N?=
 =?utf-8?B?SHgyM2JVY01Ldmdsd2djejRuVUdETlkxcmIwZnNDQnJ1UkxrWlNyNktsVk9k?=
 =?utf-8?B?WWpkRTJ2bHN4OGNqSHArWXRwWm5PcG9HbVcvUGErM1k2TE9TZWpWalBHVktl?=
 =?utf-8?B?V2thelBGRDNPcGt3TUhOcnVVRFB6M1lKTllVTklOdk4wY0U1UExhVzJkb1ky?=
 =?utf-8?Q?gnxKmuPIhussNTyCp+UwAJmK9?=
X-Microsoft-Antispam-Message-Info: ZIgRWqqQIH5Olp0A9pXzdU/FDR5OHIbqPIG0buLKSIO6XXBwnBc2y9a7dmfDDHQfzhNOPVyJ2kyJpbCa7HN4rIXBkIVXaEeLlQ53tD37GfkOzYieBrJZgKvIYAa6rFB4BLwFYKRD2wqpyvm8Efj8oB1+tEvkPhiGKv01IbtIKte1M7JgLc/cScqlDfXkQ05W4YPNffp69tVDaJZURVMp1CAzo0qxURAAYjgMpEQYcWAacxTJiX8/C7saPYTv+SSb8/Q6g9Q7d3vxpvosuMMC7WJ0ixpExIxHO9Z0Hbi8SipiPdLivASnLrHu60BYgVJ2a0fvr8SGv3fteFEh0G+1U223KkROJv04ChTaUTm8h+Q=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;6:rRl+hwaoIdIzVCrQ5Iu1gIxMCjCf7/i9HU8mLdxqTjBafg1jzZ4o34Q/jGiu/IPEPMA5S3EqXcp144Y8rE1OprCf5Cf1thOUysgV+d6gcAALmpvYLgDRmpik19elph0Ln/OsibIG9tISujI2STzlA1uAz4udnr+WK26WNlcN2AuxoDbC1xgNQWkwPbrwNtzTJruxrAiZqRYa/XmG9AJsvuZZcZDZur1XWFk9u0vyG4jHgrCbbzwh7Zkq1BlPz5xgoJKolrC5ixYX9YyXwzbfQKkT59RlJIOBrT+lPsPsxqPtvLiY1PRccaSJOLuWZeYDmCqbMSg4YcE3d0Dd9nybuPsUp8ffB20M9ox2pF0ygu3d3lBMJ4dMTSV8aNoR71HpmQodwc+kJiYSQbEaHQSqAr+7A9HLBSBfUrNAah8vVWKtc+7yjK3h37KkM0GM/kn99pHmEq+PtzWfwQRV0j6Y1Q==;5:9bAxmm8xelC6dnDMOfIw0VI65BTci/z5/8Bb2PMyIm2IiFpyV995EnE97/B6p+Xqf2OJVp0UZetLZ8kjLDS1bErSt4RgxTErdagXnWKZE+4no9TcL5CbxMsGv60Vj3GzxDfH8b7BX6oQqUK6qPyyjFsL8nCh0qXokRveM1d6ts0=;7:xJqxqRJvfHrMIQpfY/XvrEQfeIEeWpdIOEFHRC5T0EhNMxU/VdoHdfz7qfA7YWLgejZ2G7P2aGxn5QJ2Jvk1XfNbPCqQRRZWVEJmZ59kyIoS40/79OoEd+zOBG+1aMt4PcaRq/BEuJDbRIoCDfiG0ch5k+o40xS+ikFzAFovtfq1xhiCyw9+ppPsxX4D0Zr0edeIbL8xvey35TR01njLZlajSMU+/Vx8yT35bYXk657XDchNNTsubwxu10oXI63d
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;20:4aLhz8KnGZEnbIYX+/8Wi4F97xTbVAg90iz6W6FomN5ttopumUu7eAvouVVCMGRr/3erB8fSq0AzhWkg5NkdS0TKu4yKMaJ1TapY6NWd6+n/XXk347u/JITz17vEpvVSejWs3e8O7+n2e9tuoT5ejgwQ7l9MDjgzCCSeTyOW5+PXWcLs6U5WKgfhYW+ZDaPnVBLcW4yENUco4+YlS8/oX57LmruLTTcr2zFuO40V6Ndts7JjxVeAsQ+XIVY4e4Hv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 15:33:27.0645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bdbe50-df73-4246-39ab-08d60dc4c41a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/2018 10:03 AM, Sean Christopherson wrote:
> On Tue, Aug 28, 2018 at 05:12:56PM -0500, Brijesh Singh wrote:
>> kvmclock defines few static variables which are shared with hypervisor
>> during the kvmclock initialization.
>>
>> When SEV is active, memory is encrypted with a guest-specific key, and
>> if guest OS wants to share the memory region with hypervisor then it must
>> clear the C-bit before sharing it. Currently, we use
>> kernel_physical_mapping_init() to split large pages before clearing the
>> C-bit on shared pages. But the kernel_physical_mapping_init fails when
>> called from the kvmclock initialization (mainly because memblock allocator
>> was not ready).
>>
>> The '__decrypted' can be used to define a shared variable; the variables
>> will be put in the .data.decryption section. This section is mapped with
>> C=0 early in the boot, we also ensure that the initialized values are
>> updated to match with C=0 (i.e perform an in-place decryption). The
>> .data..decrypted section is PMD aligned and sized so that we avoid the
>> need to split the large pages when mapping this section.
> 
> What about naming the attribute (and section) '__unencrypted' instead
> of '__decrypted'?  The attribute should be a property describing how
> the data must be accessed, it shouldn't imply anything regarding the
> history of the data.  Decrypted implies that data was once encrypted,
> whereas unencrypted simply states that the data is stored in plain
> text.  All data that has been decrypted is also unencrypted, but the
> reverse does not hold true.
> 


During the initial SEV/SME patch review cycle we had some discussion 
about using decrypted vs unencrypted. At that time the consensus was
that a memory range mapped with C=0 should be referred as 'decrypted'.
Having said so, I do see your point and I am not oppose to calling it
'unencrypted' if others agrees to it.

Tom and Boris, thoughts ?
