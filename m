Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6E1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1002F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mDAly4xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1002F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934109AbeFRNUy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:20:54 -0400
Received: from mail-eopbgr730065.outbound.protection.outlook.com ([40.107.73.65]:12032
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933182AbeFRNUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFbqtEKgaDc/cw+e/MB5+CsnRECw9ZP2mmdgFHGLDiQ=;
 b=mDAly4xGCObpLobi1kmYlzpdtuDELonQPk4TOBj9hD2ybGT0vDfH+rZz7NE4Vw+xYCqa7BbfG0cb5+VQI994txTJwpUwCPTcAhrAx9Dv4SJQ9WM6T7xCtCwxYFoMnQZIrEI1P88Z8ljP8tvGP/Al2i4Pbi40C4k5r+CuRXd/wXk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 DM5PR12MB1721.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Mon, 18 Jun 2018 13:20:48 +0000
Subject: Re: [PATCH v2] gpu: drm: ttm: Adding new return type vm_fault_t
To:     Souptick Joarder <jrdr.linux@gmail.com>, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
References: <20180601192724.GA2001@jordon-HP-15-Notebook-PC>
 <CAFqt6zZr5WaXk9QSEE7100zs94Tx0p4inuXUF5WXgU8=9rp+bw@mail.gmail.com>
 <cc337cc0-12ba-dc96-c504-aa5a2963be0f@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <80a5cc74-2625-3b00-917c-fa675bfe1464@amd.com>
Date:   Mon, 18 Jun 2018 15:20:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cc337cc0-12ba-dc96-c504-aa5a2963be0f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM6PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:209:15::18) To DM5PR12MB1721.namprd12.prod.outlook.com
 (2603:10b6:3:10f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6896308e-b835-47a3-7bf5-08d5d51e4f46
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1721;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;3:O/bT+WRzXau9qvXyRbO4lJxcw0hHuY4jeMLBTZjWpjPy0C11qpVBWKq66Qd2UDNejJ9vBbvwggER3uLrUihtSTjrrRQ//Vs/DuJLo92lhJd9Cm5Lnx6lLGYSBVtphfIhlfRCLVg3vB82Cp1Xpr/WREzroXpjH5FarWY5szCZc+D7lG5aUDqUF0alBlTB7O8IwAxnRGJUFAKXDa3XTxFlEbcWFzMuP947xd1XxX1UT/a7lBTiXLuITeAvF1YmwbWK;25:t5hJI0Wi/ZMVCqNfTghv+4iieXoddIQXyqKSRkEYp+CW9uYyfM9xBlgIppvp0uGfv1sBUxztclKWU4JhQkoBMWQ3X8QXV5r3vYZMKa9yWLoSI+kaxwkwY2McUMVXfHzdpS+V4/lx5Hyrc4HAhjLNez9n4r9uCEZUBjEy58mHADifo/ZcvrCo/HxIpg0m5k396vxbFIaohT4xMvujG0bOiolEtjkigB/tY5M8EaVw+Huo1JidHmFvjvPNn8BJokvGss9rQk7KlQYUtTk2QL+TGs17Etu6Yno0JKEArEgEH1UkxNrn2FG+N5ew8ogITD3LX3NS+uusVKf6TN1H1Iwr9A==;31:ZmT9dU443EM3oaVbX2b/DTzHXGwv0VyYaapCzHnORTQaD+XonZORl3a+eEkAqeAsXrolA8bytJlxA1655LoXwqnbFy4THMXJl5fwV3iDgEu0YhYrBnEO1VTt9vaOtRIFHrcso56J5tOr9y965yRNHPa7siKozCVue2XWmdGui33LoCEiuMcW90Yxo2oAgkqFmeq5XhZgOi3zwEAYWcGj9PsSoIZfaP8amhohkST/0OU=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;20:LqDH6Dbv9a2xP31TDs9XXaDG7aXNH9+U9+dgkEf5qUk2mHbATINdKinqhQksFLLkk/yFjpVKu4PftIxbXpK2dHfkVZGQqyWcJShK9UEeFCmWYtsRQZsAA9I5ZyMbDFTPmRe7drrmDuR5C117DltVguRcEDoatRfcnM7ilKiEnsQGHtR/K2ipf5BNWjxjKU5izCtjxfIhiiSi3LryXXlDWyloH7S4n1xY+7Xz1VUzN6KXrE9eSZ9Qc1Rndp/mKDW91742MfLRUFA4RCLVXZvAbAZDbP1ukneZQtuEOdL9pdM6lPRiooZXgQSQjBMTysyG/Oh0aMMkoeRS/djSDsB7JO4dK2qhocGeIx8o2fAiqXfO/BrSmgGsflY0ywmOQXyn/zvhiMy1nQkM/QUZ3hSUQlJtKi21asjYT2czU9t4fmlxfthYw0iAoO3vbldxRGOpsrEe4vIDRBemC+A/Wt9gljMx1B4nbrU+bL/QJ+WGa+7xWlO1j2CFyU8uTqAuX2JT;4:4o+KZsvGedTbloKJv2tIAnombaZis5scMfnSzVvP/jeMuu9wfljsM1F8ubng7w4Ygj5iFHhcSZtlo7bo03zQL+OX0KFiic2k+PBRUK9TENOhKlrMEdnu6dytXnxl6AciWwdvarHeh7uC9wksAO7YL44uXBa8GnLgbpMQscnecVu9JZNX4X/7/Pavum/RjGur6bPu7Hy8vGh47zg/oy8yZ7gBeB2HXW9XCpIXtmqi5xGinplI0hyJAnoyRHn8W4EzZLuu5lJDxHASRvAeMi2s+d4EPNZXbbnPnz57MY1rgZWjl0uU9aDB2Wm5KHelw2XdoCIFCngNxJWBDGOqn1z82A==
X-Microsoft-Antispam-PRVS: <DM5PR12MB172122CC9352EC05343396B883710@DM5PR12MB1721.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1721;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1721;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(396003)(39380400002)(189003)(199004)(2906002)(31696002)(23676004)(52116002)(97736004)(46003)(65826007)(2486003)(5660300001)(76176011)(52146003)(52396003)(67846002)(65956001)(65806001)(47776003)(86362001)(68736007)(106356001)(16526019)(105586002)(59450400001)(6666003)(186003)(36756003)(2870700001)(4326008)(53546011)(386003)(11346002)(446003)(8936002)(31686004)(1706002)(58126008)(50466002)(316002)(81156014)(72206003)(81166006)(229853002)(8676002)(6486002)(486006)(476003)(2616005)(7736002)(39060400002)(53936002)(6116002)(305945005)(6246003)(25786009)(64126003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1721;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIxOzIzOkFDc2J3ZW5FNTN2aDFFYmFvME9WK2lhUjNJ?=
 =?utf-8?B?NDcyTWtJQ1NrS1RlWVNqaUxHYjZKQnFzRWU0YStFOGhOdFRxV1FuWVJvOTJP?=
 =?utf-8?B?TEtHWjMxaVZSemw4dFJ1RWw4KzZwWUtjc1hJYytobnI1WXh4K1hoaXBON2hP?=
 =?utf-8?B?TlBSaEJ1eE82SGZCOUxBanpDc0MwUmw3emZjUFFhZnByVHlyR1haQzdOcEVH?=
 =?utf-8?B?a3ZLaHJCR0VOQnU4bmlPNnBhL3RROXBiV1UzbGtDY05xNHdRZklERk96cmpX?=
 =?utf-8?B?VHZlai8wZXRsZ1N2OWJONjNOeU9DQktXMmUxMlZvcit0N3NwUGg3Z1ZBWkxw?=
 =?utf-8?B?ZzQ5TjNvYVhnSkEvNXRLL0xLeDhKRVdYcm9mME9peElCL2plcXlsR2VTSlRp?=
 =?utf-8?B?UXplVzNGUERCcWFIZEZqVWlDUk1qU09OUzVEdkUwNWxjSnhObFVQNnkycW83?=
 =?utf-8?B?MTlCRXJVbks2dUdhdjNkREgraHkxNGZYellWa1BCK094cmxwT0pJSDc0MjhY?=
 =?utf-8?B?TnJKb0JXOVhYYzREQjF1WmwrM1Z3QVBYM1dTVTdjZmxTak4yL3VNMFBaeW5j?=
 =?utf-8?B?THVnTTRiZDVpZHJqV1dSYzhodTR3dnhZSUU4WUlCRVRZNnByNTZGRlpPSk5U?=
 =?utf-8?B?VFVra1pHUWZOSHNjbmFtU2kyUHZwMEQ0SjlESFZXS2JJSVFodUFtZjFQdUdp?=
 =?utf-8?B?QVZ5blZTQy84bUQ4aUtDbmFXckZodThVZjRmcEZoSVJ4UWtNNzFWYnRTUUx5?=
 =?utf-8?B?RXorU0hRUy9ocUV3TmZoYkdlZklZV1JxbmlDQ2hjb3o4U1lpdDFyUTd2NDhU?=
 =?utf-8?B?S2lYYTZhV2EyUUZNTTFRdThkdlZSaHc3ZW54d1hRK2Q4blpvRHB2bmdEOTRn?=
 =?utf-8?B?cmFNdUVoaWZRY20xdkVIR00wbVRHb3FvSnE3MDl0S0FPNHNRUFdNcllydWE5?=
 =?utf-8?B?KzAxZTVDb0tZY2hZUFhFNUFsRzcwaUFTSXFmaStMSjkyS0szbzBhaElvWEQz?=
 =?utf-8?B?MWpTeTIycEw4dFU4bzEvb0dIUjFuSCs2dFgrSm5QOW54ekxFTnVwNHV1NzhC?=
 =?utf-8?B?TXFBUXZXa1FGVS91Q09HUjNtSzVueGhuNm4zMnRHeFkyMGpDY2dqc3Q4Y1o0?=
 =?utf-8?B?MnBhWnBaTjVCbUw4eXNBRzlmbmgyU0VLSWVyVjlDOUlLQUlRemVjMERwTEdP?=
 =?utf-8?B?bFhTYlZVNG1sVlBkNGZhMDIvR1FRMHpTNzRaY2tjaEtmOVJmU2g5UHpUR08y?=
 =?utf-8?B?VHloRVV6YUpnejFrSkxCT3Y5bXE0UHRvMksxMXhMRXhZVnRvaFlNNFJBK2cw?=
 =?utf-8?B?QWlyZ01ac1BqZm1xQ0NKVFdRbmltYTE1TFpJTGVzNHlRN0JxbUNPaFNUSGwr?=
 =?utf-8?B?MlFHbyt3ZWRtTGJsdDZsNEhrRzZtb0FwV1BFOCtJZlNVTDRzWTA4Tnp2bDZj?=
 =?utf-8?B?K0xFbW5EUFNvckErL2d5UXZyWkdlZDh1NHF1ZjJxK2gwNldxZW1QaEVsOFYz?=
 =?utf-8?B?U1IyY05PbmdVdnRMTENWVisva1ZrRGh6RGxxWW5KN0EvYWdiMlN1amZZTlht?=
 =?utf-8?B?cHByemxtU0hnbnIxZU8xNEk3OEdHZzZUaElLWlNFMktMZnlXNzFKekhCdFF1?=
 =?utf-8?B?QW1USEUxMVd4YlkySlJ4MGQ3ZzFOSFBsU1JjWXVHNXcvcTNqMUc1bnhHRmpw?=
 =?utf-8?B?ZjhTT3ZUMVFBNjBBOUw4UTNhNUtHWkhpdVd1bUp2TktiTGFwUHhaKzFzUGlt?=
 =?utf-8?B?Z1NCZzdUQWVzQUNTSGJ2NndXaGlSR0JXdXFoNkZ0aFZBci90eTd6T0ZRL0p2?=
 =?utf-8?B?Uy93QTMyUDNrczMzMmkxYjkxejkwS0cxSFVwbncrM0lqb3pWUkNLK1BiZVN0?=
 =?utf-8?B?Y01XQUV1WnBHQVQ1V0tOOHJtQmtuRmRrQy9uRU83M3FZbDBKVG1DZUJQZXlZ?=
 =?utf-8?B?QXdQVHFST1FBPT0=?=
X-Microsoft-Antispam-Message-Info: vGnPonR19JDredyhflvBi68kYp95CGrvALI4uFng0PRxPOFtxbFJYFFj+K1Pa87uKq+NaXg8pPwf0pDL6jSbcjkDdp7+bZCiWJi/CV4RUmWpXFBbPQ3Uji0gd5DhjwjKujgfI6Ugdhv5aP9nVfCkn1aXcDobCORIvF1aQE+4PMFHwX0FQwb2DqXZjppKqy7V2Z1ekDqaFC5qOufXZFpLgOocSCLT2WmAvXJXPmifAjTaB3ak8gyYZXIvjn/mUXg03+WA057+Fiix1gGyVTW7BhdqKvVuHxuHhMP5KH+kAP+4StNYdcM6c6Vgnl47ppT+H+SjD3/49aV6aKX1WfBYKg==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;6:+ziLO4H4oExFk9CQgc6hL+pyJ72aZGdftxbF4rTp1KPM67GbeAXaUWXAx2+6qvEEGbWEyJDpE4Dgsr2AWdf3lT5IVXpei80jvM9cnag1FCycb5Bi4hn2zixbxKXunRFZ5uLl+IXdCiMZAylkRjhrQpi+cO77tFhSj4e1z2RqtxVkKrcSYHLrvrbLfveS+3YMwkHICTRUZoB/xN02zdRzJ+g3ESI6hL4htl5lhCLpWOOCorLPTq2sqW5bTiKkbDMhUWGs6dTBZQJeuvr4bhpSujuyVQbWZf+/sRfHqOqawjAHOSOlI88yuyxvh66d90dYZmGo386oaXp/LpX6yleHn6gRs/v/TnZ8yK+SoSG5lwqC3FOKEFuVBFyuB4u1AAEY8LFPctdlpxsB/x5XCJPZVx92wmmsNSw4wTz5Tj/C2CH1qo/Fns2EXY4adhFKLhkk3qOxyLH0VZOGCP1UyijaLg==;5:X+X+SGkis3/QlYFAtIxUSYVOtHrI24b4rlokPolMfwHmK0XYHcvYKDDDCdJDqRWcwp94SkB99Qgi+d0D7ZpD/ROA8wTFVFpipewj6iqns1HIEULDd63jylVHBCFYxxyc18BpUjsWGn5GJWBw4lznj+pODPm/1Y0mEjtjVJ2p7zI=;24:WUT6a3rnYxyARZQR1jUDp8nj0RYWo9bE2+UkbopHPCqKWp64RR9FJnOgFgHJhPni1FFYJPWyoSaOCKzoa5iWRbgUYz1IufXjUkiQfe55RFk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;7:3T+DSsiiVLUMvKiUnuCRwF6o2a1jCEAT0w0s4egZiMXKHzz2jEkkwlXHcEkGs3zQWAn14acsvPHvrdbMknsq0w3D6q0qNsNNQtjJl9rXb4S1f8R+hTGEIiuM1Qac1fISe20iY2KUTiNH3fNkKcUZgE3cPvHK1+BMLIV16aT528bdNlgI8QaQWpXjunAi/nuUrvQUjCGxXxPPnXVMU5gh/ChUXwAcqLkMQFk+gupPzDc01PO5sYuRvi5mfXhQIxYq;20:pMXhDrz9dJZhpRSocV7TXn9JSMfx6DXpQOomn1NELLUSolwEXPGx8vHQule06XN1SGlTAwtmP420aET/jVMzjq630e6/rdNqii1uypOwbnAQ+n6+uuKfUpREyC5RonUC35d9q0JaLJKquwRUezfIswEaoDGvo+6bjs4DwOSCwzuayah4/CMTarNlgChafVf5Uf7gNMnn86UJct9UaHGuJh4lxxRtJKsfW/Jjewpb4miAfEbgf0pDKUfd4VZI6mKE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 13:20:48.9089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6896308e-b835-47a3-7bf5-08d5d51e4f46
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.06.2018 um 08:44 schrieb Christian König:
> Am 08.06.2018 um 06:36 schrieb Souptick Joarder:
>> On Sat, Jun 2, 2018 at 12:57 AM, Souptick Joarder 
>> <jrdr.linux@gmail.com> wrote:
>>> Use new return type vm_fault_t for fault handler. For
>>> now, this is just documenting that the function returns
>>> a VM_FAULT value rather than an errno. Once all instances
>>> are converted, vm_fault_t will become a distinct type.
>>>
>>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>
>>> Previously vm_insert_{mixed,pfn} returns err which driver
>>> mapped into VM_FAULT_* type. The new function
>>> vmf_insert_{mixed,pfn} will replace this inefficiency by
>>> returning VM_FAULT_* type.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> ---
>>> v2: Address christian's comment. Put reverse
>>>      xmas tree order for variable declarations.
>>>
>>>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 45 
>>> ++++++++++++++++++++---------------------
>>>   1 file changed, 22 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c 
>>> b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> index 8eba95b..9de8b4f 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> @@ -43,10 +43,11 @@
>>>
>>>   #define TTM_BO_VM_NUM_PREFAULT 16
>>>
>>> -static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>>> +static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>>>                                  struct vm_fault *vmf)
>>>   {
>>> -       int ret = 0;
>>> +       vm_fault_t ret = 0;
>>> +       int err = 0;
>>>
>>>          if (likely(!bo->moving))
>>>                  goto out_unlock;
>>> @@ -77,9 +78,9 @@ static int ttm_bo_vm_fault_idle(struct 
>>> ttm_buffer_object *bo,
>>>          /*
>>>           * Ordinary wait.
>>>           */
>>> -       ret = dma_fence_wait(bo->moving, true);
>>> -       if (unlikely(ret != 0)) {
>>> -               ret = (ret != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
>>> +       err = dma_fence_wait(bo->moving, true);
>>> +       if (unlikely(err != 0)) {
>>> +               ret = (err != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
>>>                          VM_FAULT_NOPAGE;
>>>                  goto out_unlock;
>>>          }
>>> @@ -104,7 +105,7 @@ static unsigned long ttm_bo_io_mem_pfn(struct 
>>> ttm_buffer_object *bo,
>>>                  + page_offset;
>>>   }
>>>
>>> -static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>> +static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>>>   {
>>>          struct vm_area_struct *vma = vmf->vma;
>>>          struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
>>> @@ -115,8 +116,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>>          unsigned long pfn;
>>>          struct ttm_tt *ttm = NULL;
>>>          struct page *page;
>>> -       int ret;
>>> +       int err;
>>>          int i;
>>> +       vm_fault_t ret = VM_FAULT_NOPAGE;
>>>          unsigned long address = vmf->address;
>>>          struct ttm_mem_type_manager *man =
>>>                  &bdev->man[bo->mem.mem_type];
>>> @@ -128,9 +130,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>>           * for reserve, and if it fails, retry the fault after waiting
>>>           * for the buffer to become unreserved.
>>>           */
>>> -       ret = ttm_bo_reserve(bo, true, true, NULL);
>>> -       if (unlikely(ret != 0)) {
>>> -               if (ret != -EBUSY)
>>> +       err = ttm_bo_reserve(bo, true, true, NULL);
>>> +       if (unlikely(err != 0)) {
>>> +               if (err != -EBUSY)
>>>                          return VM_FAULT_NOPAGE;
>>>
>>>                  if (vmf->flags & FAULT_FLAG_ALLOW_RETRY) {
>>> @@ -162,8 +164,8 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>>          }
>>>
>>>          if (bdev->driver->fault_reserve_notify) {
>>> -               ret = bdev->driver->fault_reserve_notify(bo);
>>> -               switch (ret) {
>>> +               err = bdev->driver->fault_reserve_notify(bo);
>>> +               switch (err) {
>>>                  case 0:
>>>                          break;
>>>                  case -EBUSY:
>>> @@ -191,13 +193,13 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>>                  goto out_unlock;
>>>          }
>>>
>>> -       ret = ttm_mem_io_lock(man, true);
>>> -       if (unlikely(ret != 0)) {
>>> +       err = ttm_mem_io_lock(man, true);
>>> +       if (unlikely(err != 0)) {
>>>                  ret = VM_FAULT_NOPAGE;
>>>                  goto out_unlock;
>>>          }
>>> -       ret = ttm_mem_io_reserve_vm(bo);
>>> -       if (unlikely(ret != 0)) {
>>> +       err = ttm_mem_io_reserve_vm(bo);
>>> +       if (unlikely(err != 0)) {
>>>                  ret = VM_FAULT_SIGBUS;
>>>                  goto out_io_unlock;
>>>          }
>>> @@ -265,23 +267,20 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>>                  }
>>>
>>>                  if (vma->vm_flags & VM_MIXEDMAP)
>>> -                       ret = vm_insert_mixed(&cvma, address,
>>> +                       ret = vmf_insert_mixed(&cvma, address,
>>>                                          __pfn_to_pfn_t(pfn, PFN_DEV));
>>>                  else
>>> -                       ret = vm_insert_pfn(&cvma, address, pfn);
>>> +                       ret = vmf_insert_pfn(&cvma, address, pfn);
>>>
>>>                  /*
>>>                   * Somebody beat us to this PTE or prefaulting to
>>>                   * an already populated PTE, or prefaulting error.
>>>                   */
>>>
>>> -               if (unlikely((ret == -EBUSY) || (ret != 0 && i > 0)))
>>> +               if (unlikely((ret == VM_FAULT_NOPAGE && i > 0)))
>>>                          break;
>>> -               else if (unlikely(ret != 0)) {
>>> -                       ret =
>>> -                           (ret == -ENOMEM) ? VM_FAULT_OOM : 
>>> VM_FAULT_SIGBUS;
>>> +               else if (unlikely(ret & VM_FAULT_ERROR))
>>>                          goto out_io_unlock;
>>> -               }
>>>
>>>                  address += PAGE_SIZE;
>>>                  if (unlikely(++page_offset >= page_last))
>>> -- 
>>> 1.9.1
>>>
>> If no further comment, we would like get this patch in 4.18 / 4.18-rc-x.
> The patch looks good to me and I will pick it up for the next TTM pull 
> request. I don't think it will make it into 4.18-rc-1, but 4.18-rc-x 
> sounds realistic.

The kernel is still compiling, but as soon as I know that this works I'm 
going to push it into our internal branch which brings it on the way to 
4.18-rc-2.

Regards,
Christian.

>
> Christian.

