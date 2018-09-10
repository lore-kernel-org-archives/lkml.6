Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B93C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5FD20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dKmVNKFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5FD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbeIJR1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:27:12 -0400
Received: from mail-dm3nam03on0078.outbound.protection.outlook.com ([104.47.41.78]:26400
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728087AbeIJR1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wPBsvuDwWLMTq7GLWCZBynkJT+MMOdvqh2ufscmMmE=;
 b=dKmVNKFn7Cknx6mrAKhrSfL+VTyYJDt/paZf2dTTeLVzE+4bWg0cRx61egy6ZIAnA4/AAzfefScEK1mvUS8VR/VEAMshm010BcCYKpAvzcfMlYs6qsSoDh5SxX35v/nSHanZGUKq4RfrhV/6HXcO935sh0/Sz2RQQQGARSAaGxk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 DM6PR12MB2681.namprd12.prod.outlook.com (2603:10b6:5:4a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Mon, 10 Sep 2018 12:33:16 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 3/5] x86/mm: add .data..decrypted section to hold
 shared variables
To:     Borislav Petkov <bp@suse.de>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-4-git-send-email-brijesh.singh@amd.com>
 <20180910115443.GC21815@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <120d3a25-7718-19f9-f179-fa3d70c644e9@amd.com>
Date:   Mon, 10 Sep 2018 07:33:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910115443.GC21815@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN4PR0501CA0155.namprd05.prod.outlook.com
 (2603:10b6:803:2c::33) To DM6PR12MB2681.namprd12.prod.outlook.com
 (2603:10b6:5:4a::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3fbb043-18cf-4061-d66d-08d6171995e4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2681;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;3:Kx3AmxVPzmOP1xVluSTXnEaUsBCHGjCMyBRL5bcAXpGZp/EKql0rdJ41xDBGMaKoPCmYU46K9ZxsNX/5ej4tAfp+gu89jq4GLSEV3s+BUXDOQUo0SmeuHHC1GZSnxfikebdHAt+sNu53f9LXBHmiaGrBxcgUUGxC2L3qt0+8bbivEQvxabHKkEuj7SgI2gNnS/YQsL/vWUWGvzN26Wx2dCe4Vedatsv3qKblPUnvQwXonLUA+oqvkh1xQBYi0odW;25:koXOhkGvDusBNn+bVj57RnnmTuK56z5D/aKvJYsl+/pAXl0wWkm4CgXHOkujpHQfJ3XXtRLb8kcD3HYRksn55i3uncPZKDC4a9xBYMTpODpj0q1BiBprOD3REpDqHQ6eFShdTsEmXCwLVtKTJPmekHW8udovFRpHQD3wtrVKvJNctpuz+2cIPujcsMK7xCs1F8fKCNBLXq5fLsLCmGOtBJVIH8Nn4XjXD/k5CjJlXE+auhJZHeQ2bJg1T5EBNkLcbSfypbjGTbmtPsmlepun+N4AjGizR/DpvafAUa8s1l2oo1eXoqe3v42W9X7GQjLZazJGqUlbtCxTAwQKiMIA+g==;31:n2f170UXV4GqZ+ybVuGkIK58P4T5BSxy5S35jUozzAK7N1tCa6RJ0fNJKZw2pBIPONqSPiWEMxmxe5zF0XwIawsoi6zggoSWzVetWrQujgt5NGkxJ3ZZJny8fWvg1u+UNtJO6Cs+nTQF0TxHAm3g6nDWaieW4U7jQx/MTU4BiFMTyJ9YZzBPNHRSe1yz9BYH9TkpgpyltDdCGcHCPxzrQA35DeJjWhjjHsixgejqrJY=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2681:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;20:tP4z+T7dgjhs5Yd3U56/X+zjPqfp7/xv6OSXnJHhQ/sws1QO7zZ54O2s8iAh9bK5QZ1gyZHLw8uE4gGozIc8+GNJiDyA2aeReZBMkZATKo1vBjHE9VrMaE8BD+SFSzBwX/mfbh9EDAFiMkqpe/hV4KfkIWsMZZxGMxJDtmVV5FDpyOm2qSYKY0K7ErThti1R9JVWI07TnWVCuUTvbqZ968AE3cu/NpqzDhIS/YREVt29+byFcfZfggm3awST4j+HfS7rP716N4TBiF4Dqe6xDRsD3l8WTUJml4excakMYtGSkJJMaPXK5HUuskBY3l/QFd2y0TBEhat5Z5o9VpFeBlwWR0o+VN2hMYPyk9e17sL353rX7dq7CEvBDG804ZM936oNrOJSvzn4fJ216hpiuO4WzlWQICDz1XxHVdwvsKp0N73a8Zb2OfwNJplHialfInxQRGyP26iAmLdSHxuDX5RhRCBCbZvIQhQMManWKYAKNfwvIwtWAdMdAFCTBzg2;4:Hs/AfRU+tM2RLOUJ4SdqG3SqRq7k6ziPpNk1RccyAl8/Cuz+dYCixURow0FTn0AgNN3GsuM6Jwq1B6HuVf5LP7wE0W/6DmFJYl24iW8AE1URq50p/VbDpto7nz5L4Hfggk2Vl5l6a79ySChLjJuTZgLWbH5uoJ7GbYUZ9wWJQWopS75KYSSC2Wvd34mUmj5MRdc43TidhcTOljXtP6h12zFNYndzqMbdJDoXgq/vOsnwG7lfdLsVE46R+WLZXnSO7xDXRmCKLR9kq5qtLyhCEQ==
X-Microsoft-Antispam-PRVS: <DM6PR12MB268119C4665ABB6A725169BCE5050@DM6PR12MB2681.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:DM6PR12MB2681;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2681;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(136003)(39860400002)(199004)(189003)(97736004)(58126008)(476003)(54906003)(16526019)(65826007)(186003)(2906002)(86362001)(26005)(65956001)(66066001)(65806001)(44832011)(47776003)(956004)(230700001)(50466002)(486006)(6666003)(5660300001)(2616005)(6916009)(316002)(31696002)(53546011)(6506007)(386003)(64126003)(11346002)(446003)(81166006)(4326008)(6246003)(36756003)(81156014)(76176011)(53936002)(8676002)(25786009)(52146003)(6512007)(106356001)(229853002)(2486003)(23676004)(478600001)(52116002)(8936002)(68736007)(6486002)(3846002)(6116002)(31686004)(7736002)(305945005)(105586002)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2681;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgxOzIzOnh0VHQ3ZGRuZnZuQzJpanc4V1dmNVRQWUhE?=
 =?utf-8?B?cTlIbUc0a296ZUw0Y2Z6S3pQMmMvTlQ1dEpudkNvSEEyM2ZiVGdMVEhOQlRI?=
 =?utf-8?B?NkZsdXBlc0tCdEVrYkZDd0o2aGVhdlNwVSs3QU1qQUhzRUorTEFneS92K05S?=
 =?utf-8?B?bUwrUjlRM1JWcU52WlMxN28wb1MyV3dFWEV1UU5uTUxaTVI2NFJSdVhBdld3?=
 =?utf-8?B?dE9wd1NZbU1rNUdYbkxSSEpmOHF5R0lqSXlCdS9kZW0waWxXWXJpN295MkpL?=
 =?utf-8?B?Tk9QbnU2Y1gvR0hsUEZKZmxaY3JHQXBZeGxENGZiNFlZSkM2d3czbndVNi8r?=
 =?utf-8?B?QmtNRGFLMW5EdW5WcnprQTI2RUlHK2llRm05ZWVxbzhxajFjOHFsSU15VTB5?=
 =?utf-8?B?SmhTK0JmV1ZSaGVhdlhMWnhzZGY1c1p1TTlUOTk5UWpVeFpmS2ZDS1ZqK0hp?=
 =?utf-8?B?cDQwNmJTWG9yM2c2WVZkbk1MdzNzTVZaQWQ3eFQ3cHl3OUErTFMwaUdEaG0y?=
 =?utf-8?B?eVRhaGN3cGdrbHRQT0tSeU9JNkV1S0QxSlZlNU5DNXNvb2Z5VDBIYVFwRG1m?=
 =?utf-8?B?RHNZYSsyMk1abkI1UWxsZHJrL0JndmEyNy9FVVo0OURNMnE2RURITnZLZXRy?=
 =?utf-8?B?TEJZRDI0Z0RmaXlzWFBkK0pnZlFERVNPUVEvR3F4L0s5Q1JvUmdHM3RzUW1i?=
 =?utf-8?B?V1NldnNqUjQzcXArdGhaV2JlMHJaRHYycXlCQjhjTmZSaGFOL1BwZDJoR2Vy?=
 =?utf-8?B?OEVzUTNyOWxSRFJ0MmZyNThqWDgrc3hQdmZ6YW9IS0UrMmhFM1RjaFJpRjZ4?=
 =?utf-8?B?bWlBWHRvOURScWErTkRHREVTMEh5TFNjZURUR3JPbmRwdWpVUXNmM2E1cGRD?=
 =?utf-8?B?MEVHMTZNSCtsYUtwK0o5WlBlNUVHdUROVXpZQXBWK3poVlp5eDdWbTFRQm11?=
 =?utf-8?B?ZjRsc3pjN2RpMUYrRDU3bTBlSTFjdEI0K3M1RnFmMW5tSzNxclVvcFJjSUlP?=
 =?utf-8?B?Ykt4NDVmZFlFY25NTUJQY2JTWGFjbjA2L2VIaGRLVVRnekFIK0p5d0FoMWdQ?=
 =?utf-8?B?bWRPdlYzSHB4b25RV09hRDFXYnh4aXR3UVNKaU1NOUJoaGl2MEsySHZ6RkFZ?=
 =?utf-8?B?ZHJoazcwYkFVUmJ5WmZVTDd0SDViSFhINUk1VUlZWTNza1ZsU0RxTXEyNVBV?=
 =?utf-8?B?RU44NEZjYzBoMFFDT3o4ekNQS2F1Z2h2MHBNcWpLRFpxZHJLRVJiT3pzZFRL?=
 =?utf-8?B?d1Z6ckx3cTF4UWIzWUM0ZjZoN2hLdmVFbndVTVQzeURiaDNjMEJZcndVeVR5?=
 =?utf-8?B?bXc1TjN0QjFWYXpweHYwMVRXKzkzajRGT29vYndEVkQ2RGs5VnJUTkJBbFU1?=
 =?utf-8?B?YXEyeVQ5S0FsVVJtdGxPLy9ONHcrZ05NdEttZWFrc2RuVis2KytsWFNWNTFR?=
 =?utf-8?B?MW14TENpZklSRkxDTmZzc0kzcXEyejl2ZDZPOHdzTnBJYmR6Q2s1VS9PM1Bs?=
 =?utf-8?B?TlpDWU53cHpFZm5hQmxLZW1WNW8yamxublg5Ujc3OFcvMTl2V2hka2UrZ0xK?=
 =?utf-8?B?d1oxTkRkOGlweURWdG85eXplZ2NNRVpLeVhOUjZhOWR1TUUzRkNXZjRQWDR4?=
 =?utf-8?B?V3V6c2R3cTN4dFFpWm5Mam1jUzl0NU1MV3JZSFhYcDJ1VVNLdHdXcDkzUlBG?=
 =?utf-8?B?MUZxT2t4THlFOEh6am9hQTJqOGZZbGFZNm9OZzgycHQrVElFL1dYbndWVjRW?=
 =?utf-8?B?MDg0SDJ6Z21BamUxbVZnbi90elVERTBsb00xK25CcHZGcGpoMmhqdjhCVlpj?=
 =?utf-8?B?VnNMczA1YWxidE9WbHlWRlJNNjhzK0VlWFFFN3d6a0lSR2F2VWVqZDRrUU1l?=
 =?utf-8?B?aTk5eHFQaXhVYTk0MENQRjlXdVNIWjd5a2I2SVE2ZytwRHA2S1Z6OE5ieVI1?=
 =?utf-8?B?MHdiMzdxVTY4MTZCUytTWFRwaVFPazNYbW9DRmwwTVdyNkl3UUVCTFk1WmdJ?=
 =?utf-8?Q?TKJg/5?=
X-Microsoft-Antispam-Message-Info: pbfBTpMv70jSxGOKPsn31dCXoZQGCwovqGm9jVpDJo4rFO3X8bJV2ch5THUUg0xqy5srgQO5nAnL0o5lF/W1OUU4bzwsG1cRLy7OvVc9zrfaqRpRHClx/jjB9cKEdZcO4aTWWt47mmKL2BDzp/OaHnbVHY9MfKf9G5mB59XhLohwQ+OC+fO+YdvqK4+OGDMyEg/YTCPxcxN603Q9yMDCqBe1xOUGm5rr2k5JjpelH/BzmtEzYV9YWgvT/zA9Ayg/v9iD0RoaGfHDJG5NWVlgv+guEW6rA07WH//A+WrVvnzSiqo9q93iJCONvtLL+03ncGtMiBI5DzyDPjoFBF830GAUMayyY216JKsh1ae9AzM=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;6:vfFY2/odkz8FHXJnxJ8zcNaff73rEg1vbQJ3HPWPn69M8utkb3R1Kv+U7W9hdoetFXnzuOLsMvQ0Mkmd6sNvYrQbQGlyyj/s1hpyNt0qS7nV0/La052cwGPHA3K115i0vyHhpJsh6aNNJh6Dbv9rq6iOM1iFV/V5cwTqyEG4iFkvXiwZqKN9ESYOU+khA4xgvjhlJEk67pTAITFiioFLa4sb2K/hOMhs8tQVES1ed8UBsFZoXNvad+uabeSmU4TjqB75l+lFmDfM8vj/TCrD8COyfXdidrC0Ijwjns3tk8COToIZWT5rtD5ZzkWGGbGHuEYMj7W6FHK2jW/rZ9WQpXDR04uOD4MzznIz5VGu5mXpAk/jKc4S/jN4ZE6aE/b0zvS/AFfMSlkoJBnMhyTCwv9woDmfcNPAKQqcO9/wg4JDQt9/gabu9SEf8bA3Eh/Ea6dGiuf9U6SowFeTWRztxw==;5:/4Ml8DqC0qfR5JIHKuY/g3KbYbl1jd0V+/7lgC9p6IoFc5Yd74jU/etUK7FXh9w9V8cPSHKa9VEl/92IG4ZVXTJbbupuZYnNj23aZbUlX26LyMvU9HDpqIGGV0njEEbnGrbeYaLiF2A6wnj+8R6j4rL8p9iIrPtQz+KWEg/Iwrc=;7:WAC1rxRLh5qi07lJ1nKCDfoSWMKjyWCcb8+syuZAZn4qB/nZ3WVNUqGPcs2WgyE8t2LK+L+aQrU/YvxYgwOq4Zt58wVTzJCaxlZqxVj5JGHcYcNKQTfm2+MYOWn86Mz7UkpPnm6nKOZDrGBmAR60+8fbla1drkTvroGfpvt1gN0vWp5WBUjdNXoMCg5SSJiHA2wD5puhyJz+DAcxJww2etWlF/Kjsg7DnzQwO0Xr+1K599G7BUtCSjYZr9cL7xIU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;20:M70U4cFc5T4sYiDes/mGaqDyDrjrIUMIv+LSZ16ytbYW764dm4QNebrE6cYeW4DE2VNnN9D3c/i/ck3OIiVfQOJI8goluZ8aY3KP9YrAMPGPMiEQWot1th1TYvnajYXiZOl/ZF+krZnNdp/4c3xIlvJSvyTi62hhd7XJa1ZJPuBd1NyJBWbKSQlmUXAG/8wK6p/CDBhyq5MQIlt3tpaWOdTibmsHDqQoB7HIUS0XOgq8bLMCjC/yezk3P646Sqxd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 12:33:16.8232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fbb043-18cf-4061-d66d-08d6171995e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2681
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/18 6:54 AM, Borislav Petkov wrote:
...

>> @@ -487,28 +510,69 @@ static void __init teardown_workarea_map(struct sme_workarea_data *wa,
>>  	native_write_cr3(__native_read_cr3());
>>  }
>>  
>> +static void __init decrypt_shared_data(struct sme_workarea_data *wa,
>> +				       struct sme_populate_pgd_data *ppd)
>> +{
>> +	unsigned long decrypted_start, decrypted_end, decrypted_len;
>> +
>> +	/* Physical addresses of decrypted data section */
>> +	decrypted_start = __pa_symbol(__start_data_decrypted);
>> +	decrypted_end = ALIGN(__pa_symbol(__end_data_decrypted), PMD_PAGE_SIZE);
> Why?
>
> You have:
>
> +       . = ALIGN(PMD_SIZE);                                    \
> +       __end_data_decrypted = .;                               \
>
> It is already aligned by definition?!?
>

Right, there is no need to use ALIGN. I will remove it.

-Brijesh
