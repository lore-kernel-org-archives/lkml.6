Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EA8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D95920659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wFDcRZf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D95920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeIFW0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:26:47 -0400
Received: from mail-eopbgr680080.outbound.protection.outlook.com ([40.107.68.80]:56199
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbeIFW0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkocpLiTrqVyBYnd4fWOSm1K6ZpWNyMXPQE5++6ercw=;
 b=wFDcRZf6cKDBjJrIC6z1oPgB2mgOQVhA3ml0RVESVMPjL1+pkICLIc35tBLboTH54nsjX/GjnMVtEAU6sKEWwr//kOMuVINI5uiMIVMcW8HuOMrkgCm/uT2HXHqalQseFbqiLWPzhF5rdcbqDa9LzahOwo/TX6CRlK6KONNv6sw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 BN7PR12MB2675.namprd12.prod.outlook.com (2603:10b6:408:29::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 17:50:09 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic> <20180906135041.GB32336@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <5171cf03-4df7-2bd1-712e-c89717fa1ebc@amd.com>
Date:   Thu, 6 Sep 2018 12:50:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906135041.GB32336@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:805:16::28) To BN7PR12MB2675.namprd12.prod.outlook.com
 (2603:10b6:408:29::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5eab054-cfad-4d3c-8422-08d614213075
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;3:QgShoq83qQFUXT2iFSNriwQS64PPhS1i8ZbNVjDlIzkByFBh2GWwmO+UnzLR4IgPhR45xpRtW1o3B/nu7iSMoo6ODKp4o7IC0EYIzuSiaDDUI+jZVi7VJQLclttymJQ7OlwT5S2ayruyv/qSVDbnw4k27nkg8CXlDTFKFyqXJAiOuOfNCxeXTaIVY3vbH7EnJsbscBVIBvaOBzpzdrF/TlW6Et60Crna9HuG3uNlKoRSBrXtU7MI1OIkpcYmdlDL;25:s0UhHQ4CV6zX40hWLl75i4N2Gi9FGpgYUDWgQHxn4PTlHzaeLWiYLTZmNg+mD1NDBbpk2/YcUQicRlD3BYPeM4Y/nRwvCEF+Gj+GhEjVyc27g+XG2lWmRPHYNIYjWv0guYOMKnDh7xM5S0ZtpkdfsH88RrLFZamM+QBleowtmB8XxjsC1fqbe9Pw+eFD+55sVQGrFBgLCp6UVx1uOcs8c8BqjPDa4EDq0Eq+98oYZFcNAUkOcpHHXLDYJwKO2jiwZctmbmYESO8LFCBcE2hSSperOrFZnKNjoFgxxRLr4eJ6dLDTnD+jVrmNYk2bPfn2OfR1mimvXsOvjyCleH5nrQ==;31:xYWbrh0nFISLn2745hRh7i6eQWtSj+LHS/KHBk+31tZn23xT9l21i84KgxS92ggFR6LMT94RXucVqnAj2oWx8xKFs84zW0IwdaAWb+ttHp1dgh0b/HgNK+R1w2ftk7j++W67NXQkDWGQcn/mmgWf5eENLTJ0wKu5s93F4XzfNvZW1m5oJ+f9ZxvHqoSfhK9bgW2i/6Ll3676646CLpMVzhwRHIxfGGkhGWceF0+RsYY=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2675:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:F1aRiomZlb/cpT2GfXVBGNDo/t6FFwlgUD5wK6OhuB5Bf4nMOutlr1rZDdkRjJ9xdluafJAUXAiYwVtrcJuUPBoFIqGN075W7njldOK0B5H3Vposzi6eo9QB06R+eDSAEaEYtQLrkoT0rYLi5XRXKwbkq1b8OX/44r7hHKVhyxHWPAP58J0HTG2nAg7O6+1Rma9+yHCvVvvXs7RkT0aX9TbpvMs8LTFlC0Rgfvu5++P7KsFwXpvqvY8hSpQxz6JPVnFeycJPm924QWwARYsIj2G5KG2bBkNYDDZ0knWp/Fc7OS/YjoPg14UT8FCk4C7kkBlUDIGzxjhspVcn80A6EdRu+zDuct4QBqw4bHx3mFF7KZwvvqLFtsvN8pQ60Np97MATV3cduDo7IG4jdwmZQYA8yVwQ7YItU8v2uW5zyp5eSOf+KKinzjkufecQeKGmNxjyPjjNMSGqny55i8U1Mrv58CC/+Q82rjG9pTnpeU3CyxBdnSDPA9u0/eVCwVMy;4:YffE+PMlXIWp6cYYPBt9G2h8RdiVsw/tFS24oEAlNmQ/MwDwLYRm8/0r3y2ZR9XeYoOs380ljg5LXUTlctqaEdJgh6M9HS6d4yv/cmSlMGo0xroqeLIXnQeUUPTCojamAudaTRXitmWSrCMz8ptKBUXM5swxVfdjSP4pHndNvTSAWuUXXU73p4B5LsXqiQirFhPvaFyGf945J6M/yXplmPFblQFcnJ70Mlx8J1QzBuAvoJ7yj2cl7BncAV2Ljn8991KTKGncc4IbiSSxXCuohg==
X-Microsoft-Antispam-PRVS: <BN7PR12MB267595F43050D9080464DDAFE5010@BN7PR12MB2675.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BN7PR12MB2675;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2675;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(346002)(366004)(39860400002)(136003)(199004)(189003)(25786009)(47776003)(65956001)(86362001)(14444005)(31696002)(68736007)(65806001)(66066001)(7736002)(230700001)(65826007)(31686004)(3846002)(106356001)(6486002)(6666003)(105586002)(5660300001)(6116002)(305945005)(4326008)(64126003)(229853002)(93886005)(6246003)(26005)(50466002)(52116002)(53936002)(11346002)(8676002)(77096007)(446003)(956004)(2616005)(2486003)(52146003)(23676004)(97736004)(478600001)(36756003)(76176011)(316002)(110136005)(186003)(16526019)(54906003)(81166006)(81156014)(58126008)(16576012)(44832011)(2906002)(476003)(67846002)(8936002)(386003)(486006)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2675;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjc1OzIzOjVxZDhyRGJkdnNPVWdzelRWMVZ5NnpxWEto?=
 =?utf-8?B?VVRxOGpEZGF2dEY1cjNTZ1BZQ3pKY1dVMGdBQ1lVMjVjWjVlUWZtSE9leUNT?=
 =?utf-8?B?OENFbzhpMDE3bGQxWkcyMWNNZ3VidHFOZFRzakV2WUJEMFpSNmVXcUFvSFZw?=
 =?utf-8?B?VHJoMWwxUEo5WVBkNHYzK0VYQlhBK0RpY0xLY1BvVjRGYzBhNGxhK1pibWx2?=
 =?utf-8?B?QWNBcHJFeUduZkQrWnRjZWd6b2RoVXFtYnZRZ20ya0VuTlFOZlI3RU00WUpm?=
 =?utf-8?B?djJsRDYySUszeVdBTkMxN3FDSDVGcHI3aHlLRnlzZzRoS2Jsa3JacGdTZWpB?=
 =?utf-8?B?SWQ2K0xCSEsySVVqSk8zcWdOTmw3clRXYjA5bGlQQmZwOHBvMVlqVXZGTUIr?=
 =?utf-8?B?Q21zSkFYemFPeDhHbmdhdWdZTGNHdnp6WGcxZlFOZ2FJQjd4c1hWbnMwNGZh?=
 =?utf-8?B?UmFlbTZZYmxYTXk3cWNqS3ZsbmJHaSsyZ2hydTZNMXdXU1p2ajkyemlSa25J?=
 =?utf-8?B?SU9FZjZWK0grUlJSaHQvcG1aaEFjSERuYUtoQ254UVhaUnMydG92RE9XcHFI?=
 =?utf-8?B?OVY0VTg5OXArNjhLdFEwb25WZkFRZ2F6U2E4UlVLZEo4VE5iREpYd2hsdHF6?=
 =?utf-8?B?Wkw1eGdjQ1pzdjVnN3dSZHBLMWpOUFJSeXp0YTFvYUcrZlhXSFlnYkhGK0ha?=
 =?utf-8?B?YlU0QTNTOElwRmdZY0ovUmtkWThlaDhIVEJHcGpONFRaNm5DTUMxTzJYdmVR?=
 =?utf-8?B?NHlVVjNZdzhWckozeUw5dWNzeVJDdnRCcEtXc0dWU2Z0WEMycUhJZzhEV3V3?=
 =?utf-8?B?alAzSVZvcGdOU3BKRXN5YjUxUVlKODBvdm5IL3Y3UTZJYzU0SW9NZXlZam0y?=
 =?utf-8?B?UXpRNmVCaldUMWJiaXFOREVhL1VPdXRjbCtKdmdVaDNlM2REWGE3dXNhcEFS?=
 =?utf-8?B?dURsWi9oTjFGdDc2OHY2SWU2czZUYlNTT2hVd2g4OWQ3RDViT2tVaDRDM0tu?=
 =?utf-8?B?WEEyVERNYVFpcHByNGc2dW9yRnNWWURxZXVjbjZsdHVNQUZXSFpQYmg3QWJa?=
 =?utf-8?B?aVRSTjZOMGpBajJycWpiSlIyejM5QlY4cWVGL3hlb3dVY2lHWmFzSGVlWHhN?=
 =?utf-8?B?OStsT25xQUNEdjYweDRQaVJJd2VaNHhseTdPVGtub1F4SlU3Y2tpN2xxQ1A2?=
 =?utf-8?B?N1NQdXhRdEhidytjRGtNNzkvY2dGQ0xTYjQ2VDE3Zk5KK1o4UWdHa0loOWF2?=
 =?utf-8?B?YnE5TC80dmRvUEYwZlF4eTY1Zy9jVE9pb1FjNk5WNmxPQUZ4Rnk2TkpSVnBH?=
 =?utf-8?B?UUZ6REg0YmJCWUxhMllFY25VTE1CZ0Z0U1hZV082SVM5UTkxdnI5MjUwOTVJ?=
 =?utf-8?B?cVNITDhxQzdKd1NvU2dMdEdHa0YyWnQ2YlNsWDJONTA1Y2wyc3RSOHJjamRE?=
 =?utf-8?B?ekVFVzRmdllXT2FBR1hpNTZ1MGRoS2VmaWlZZnNNSDQxSHJPbjkvR1g0TmNK?=
 =?utf-8?B?RWE1ang3NjNYMnMzMm9ROXNCQXNXb01COWk5Z0g5dFBHWmhpQkZUekZaVGxO?=
 =?utf-8?B?R0VMbTN1eXdYUGttL0ttRy9qcE5jRlE1bWhEdjBPalVVSGIwQmxXUFRQcm1x?=
 =?utf-8?B?cWt3ZG0wdjRpemV3T1ZhbWxxcGQvTHFKUEdaQ01oNnBzc1FOdEx4U1lkcVpC?=
 =?utf-8?B?cDBvbnNTVzIyNmRlV1YyNzY0N1hCbk55WFBoK0ZYMHlqY0U1QXFHTXZCU0p0?=
 =?utf-8?B?QWRnNDRJanhkN2NibmJXT0NGYnNvLzYxVytEa00xUnBYMG1KYVhnZXY3Z2Y2?=
 =?utf-8?B?dUcvOFpDbWJFa3BlMHVCanhSY1J0eHg4ZXFCYm8yMVlRb3BYdmZUUkVVbU4x?=
 =?utf-8?B?Q1NUOWs2SEpDclJ1dUhnajlGbTJNRFpHcTVuQWZwTXVaYTk5czhFd3Qya3Ev?=
 =?utf-8?B?ZlBuQWsydWg3akV5S211TXZPeTZIVWlIVkNGT0l4R0hUY3F3UjMvc0FYSllS?=
 =?utf-8?B?OW1OcjhHeXBFVGR4aUJ5UDQ2Yk93Wk8remJwejJwb2VES3lXZXhzcCtFd3gr?=
 =?utf-8?Q?v7zk=3D?=
X-Microsoft-Antispam-Message-Info: Fbn/jCB3DTAcxswvPKIXiaLx2qx0FJIQJYsmdGgYiI6zDXKT2WW2ybhYVN6j2d3erwhtWLY06RpOQudvmYH/5uN0BgxKfL2n5Cb0b7xek0auUX6yyd5a0Lry8RvkcKjTLkgfBeCSBYXXhG+mEESgAVGNz9NPQSAVAs60m5SEPyHwme+728MwyVSN0V90MHUhoDSQ6k3wrsyaSVm9GO9e2nDu+aKkCpbW625BZivFz3TI2/O9l5FvsQsFNsDkpCrNITZ9kny+SXRXGoB+Q7KO4gPCP9H8HQsr/NCxnVMLL0P7IUzuu4IFOq5p1OC/vlFWeZdGxhNmVl4I9RbKONzsU65Z2JZCPhvPbEpcFuZOl9c=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;6:EUjyHWQuxxoJQqzYGAppkEEMous1oZf84RicfsdjB4YeArpB+pc6PN4uzanZg1SB4Ru8ZxM+2RFpX0Tb49lzbts3sGEIdDf8dprPgpODJJBOFmb7qJB34LeIfKr4OhFpB01IjHJhknUOA1kMyt83yBnTlkTelpneT0Kpng59iX3gGjA0UoXSaFpiJWVxR2SUyehSNG+dqzpNfa+dgV5Ad3oFQ1a3/CD0FggOqkgN/W0Iq7x7wKGwyv8XRgPhB3a4Ao5e5EtAPDUu7cZVeRoAkxrjH0MgaDtDAe82aTVqeRT0Oj1Q/7z3HyvSAK8GAnlR82ELuRNH7jgOsiuKoRsOak5V1dgaRQ/zoiXftKapiBUoM3IXEBlVEuJbaW1yZjo40+A7yIiT+U68yqK5s0YjJuhTrmodpdesjCpL2qtFqIgI6DtHZrrBKuvDUDEPVYq7g0wlX7UG0q+1Ik/Ub5uh6g==;5:67RiD6ekKRhWghp8QN7ZQS2QKF+w3mX9sthZ4ebZBYPqxg4pQlV4toPQkZBgX87ecea+AC3VR/ZzAErxscfvO0aI/GhnMbH9XX5jHS4OmLrcPDnOjaeSs1Wvs+wiNUcpFY9ZxSwK6blTonolP90pjdcc+E5mb05BxnkhsWsnjxs=;7:Voc+PaWND3CvqPRS7nIifAyASiog5GxvbZSfEwx1K0GpFeEK2nxo9vPcltDNLDljKtXoxh3hWTXIlJOEgb1GDMcFyCu4/BclGJxz9rLq2KhZEjI05E4SEyPPi5pxHk2DKa6XPsDBWAkRpbcN8uqkSzwEKr6OjGAyFMIc1yosUSRDwLZBRv8v0XYI8lW4Pso7PIJP2x6K+5qDxg2z/ZhTckM3Eyvxfv5gaoeUehMiMQ0FP6CNSHGwg6i4seeaQ7fj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:EZLoi93wONChTjgHjjt2CEZ4bPCYlfyenJUNrhlt2UqK+ZhFMcpx2Tqt6dJKl1BfusxDMUenhrsATWnxbmcCwO/i3/8XOMqhfpMA7oKtQfzVsVz6aNFomV87Dt9qu+NAAY0vUslb5xE6WOCXZgsoOWD2ofb+2YQgxIEfraoiQI+9jeuKybTOwNPHlGgM782RSklLCMVPp3GsMeJbgDCOPmnWauTIgMzrX4PrbRMN2y0h2W/cDyazci+lYSwQU1jy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 17:50:09.2112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eab054-cfad-4d3c-8422-08d614213075
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 08:50 AM, Sean Christopherson wrote:
...

>>
>> So are we going to be defining a decrypted section for every piece of
>> machinery now?
>>
>> That's a bit too much in my book.
>>
>> Why can't you simply free everything in .data..decrypted on !SVE guests?
> 
> That would prevent adding __decrypted to existing declarations, e.g.
> hv_clock_boot, which would be ugly in its own right.  A more generic
> solution would be to add something like __decrypted_exclusive to mark
> data that is used if and only if SEV is active, and then free the
> SEV-only data when SEV is disabled.
> 
> Originally, my thought was that this would be a one-off case and the
> array could be freed directly in kvmclock_init(), e.g.:
> 


Please note that kvmclock_init() is called very early during the boot
process. We will not be able to use free_init_pages(...) so early.
Additionally, we also need to consider the bare-metal case -- which
will never call the kvmclock_init().



> static struct pvclock_vsyscall_time_info
> 	hv_clock_aux[HVC_AUX_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);
> 
> ...
> 
> void __init kvmclock_init(void)
> {
> 	u8 flags;
> 
> 	if (!sev_active())
> 		free_init_pages("unused decrypted",
> 			(unsigned long)hv_clock_aux,
> 			(unsigned long)hv_clock_aux + sizeof(hv_clock_aux));
> 
>>
