Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E73ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C7C20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AVltMKNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C7C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeIYPmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:42:14 -0400
Received: from mail-eopbgr30101.outbound.protection.outlook.com ([40.107.3.101]:54389
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbeIYPmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rhMjdbeIQ4aL1leDTjZeBqSffCIii6h5QY6Ano0yK4=;
 b=AVltMKNijnWG2d7VkVCYvN2YFF/ZS5NlPlnShQcn5W79jSvTK4vyTCUTn+qmC0j6fv2jtPQkAfaZ7vnJIKaspZrq0RhKjFrDtJ2ixvwKDkUvGdlOZVTHs6tVy+rH/DJU2XVTGGRfcSkwLgKHEjN4aXTq0lurDSBmc5aHA5xo76s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2028.eurprd08.prod.outlook.com (2603:10a6:3:50::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Tue, 25 Sep 2018 09:35:26 +0000
Subject: Re: [PATCH 3/3] fuse: Use hash table to link processing request
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     kuznet@virtuozzo.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
 <153666073461.19117.1958730317836145457.stgit@localhost.localdomain>
 <CAJfpegt3ckxAUAdabXKwxgFYdP9=wVSis+G3pztWgqzXVGNFSA@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <00ffd41c-b28c-466a-c496-546ce57d7990@virtuozzo.com>
Date:   Tue, 25 Sep 2018 12:35:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegt3ckxAUAdabXKwxgFYdP9=wVSis+G3pztWgqzXVGNFSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:4:29::13) To HE1PR0801MB2028.eurprd08.prod.outlook.com
 (2603:10a6:3:50::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50b7d8d0-0681-4637-ddff-08d622ca39c7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2028;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;3:jMwoZy3Dc3bBSoVGlx4D1M5v1sX7qTd5Pnc5nDAdRtwv721Jl8ryDiv+eYw4r312DyD9+JtrAj3Z6CYsleRxGxrZ8ldzSGXGgsPz1E0mcdBG0YqRGsIZOe3cJL0+ith/PfsvBn9WBP6LcHrX7aZ51a+9IO3AMXplTMR4ipVT7kmmHOKf3XP+yb5/97X5vYcBhbZFcuFQpWAmmsTZDDFC7KyqxPwL9g5iI++ujnKAEb0u8tfkHAgXocHJIz0q7qHs;25:DQnUoK0NurznM4Ly5wfqR6i4tUFaPqfRXhDNiCRBF/T6UyHiaFsVGTiAPj9RQP4x3ziz3suLygd+u5wXZd5F0Sfi+XyCegxlPHtOVFSFg+kTdqfEb4MWBkFXIEaPdT6uxjgKVFDomrSwujfX3Z8+dxX9MrdR+zB63RztbvQ9/oG7EK7Ak4r07CuafKCEQ4WtRooYSbDGE5fILlZvRUtBzo67/JrG0WQRLXj9gU+GeRUliqwkM12G4RrFQXrG09pW8BJoI6mFHdCFE9CplyKYaOqwHch8s1yJpTWNe+9iXE4yRBJW2SaXm4Wm+2fH+qtbwoi945l+/jl/XkBok5RBQA==;31:Wy2MdneRVoICLINkPrAji2Y5Yq++qeCK6e7kQI3mLLExaRHXSPHUTlvlkERFsJnGtknw7AyyQLomgSqQ2vfGrc49M6+rWnPCahn1KHvoE9TLC6z6adIpXlejolMlEPSfwOvE126+eOM/JClXiaJh2+D+l+jr+Sn2WH9oC/ns404dFQsLg8FduOQiVSTwE+Hw62Xp1WA23f+VCdI84eguWsLnw6t8injgPhP4JYt+5+Q=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2028:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;20:GDdP3E32/B38LrSX33jhKKeeTwcqYhzjg+6d3Krwde5xlNmdNtodJXGYTOAS76M2tv2+CvRBIzFAS3pJCDP9INqpzV7LJ6j8zZcJW8nC1AUQE0wY43FKGUcjIzQFepU1nzocG3DdJrqrzJUOQsw2jVb+Exbf8epW81LckQ8jRAllyceBQgfrTouk31egz/k48T6kk3L0HvFuU7lQ7nZhNv/KENTUcPDir47FmYtMJykUANdTHi9RfDkXKmtC/71Q0GBOPMXsF6aNS/dTQ0r6vpYrcUl2mDgPHUWkPKfsX7XNWQsgNUpcj813z5N5FSFMr4Mcv992Pvc9hseverlatctnsiObXEB7xCHTPpnzRxwBSUNaKROhpmddNVvwFh3ZDIXV3wNyhebLQOs+8gLCj0vIUbF8CpunM/RNPDNGZ/J/lTWXGTgLsog1bkc+y7ub4qYmLwdBBYatiqoqeh87CKK03K4LiDqQxHF7/tSLLZSYguraNHRS6ZdjiqSwK3BV;4:CxNN2LAWC7MhxyTrDb9wkoEr0dNHnor9NZ2ux+1xZSs0VOD3yp88tCYDTt6vLmK5b37ZCtPepZNJIp1QHU62aulokx1pIRuZTtoi7mR1BM7L1e+0cQ9mZg0jXS5T00v4vuB3vX0kl2tT63ap1pM1Jk5iL12EdLXRkrMgRbrBxEgjoyzlhh/qK/pwy6g/2su/NXlSBz1rTADBr/8vA5UhVf7lxyfDkOhZ2pkGpG+uP0AUcbEI4UBjHcLlTMZaf8u97RTwW81UqDsEqJR5wt6rxjGmOVBJyMZtKxn18kXogyd8VcNkpmDZ3aVl3gSoVJ9n
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2028ED816E470FE32DBD4FDACD160@HE1PR0801MB2028.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:HE1PR0801MB2028;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2028;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(346002)(396003)(136003)(39850400004)(199004)(189003)(53936002)(25786009)(97736004)(2616005)(476003)(11346002)(956004)(486006)(36756003)(446003)(31686004)(6246003)(64126003)(6486002)(23676004)(53546011)(2486003)(52146003)(4326008)(76176011)(52116002)(229853002)(16526019)(186003)(86362001)(77096007)(478600001)(47776003)(66066001)(386003)(26005)(65806001)(65956001)(105586002)(316002)(50466002)(2906002)(58126008)(16576012)(7736002)(14444005)(8676002)(106356001)(31696002)(6916009)(81156014)(6666003)(81166006)(8936002)(68736007)(3846002)(305945005)(6116002)(230700001)(5660300001)(65826007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2028;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjg7MjM6eHQrMW11K3VNM3RQaTdUeVBLUmVBbE5w?=
 =?utf-8?B?VjdmWDRqWHBjWnBXUmdBR0g4R0p1eE9yam5oTk9xYi9hZXpUZHFkZ0tLcFpi?=
 =?utf-8?B?QVQ3bFluQVlVdExHTCsxUER0RXZPSDY4ZmZrMUFDcWxQV0x1Q21qQmNCTktZ?=
 =?utf-8?B?dUxiOUd4OEpSaVByQU41ejQ4aXJVck1GQU1DdHpqZkViTWRGZHcvS0ZYaGxL?=
 =?utf-8?B?Y01MVjg0YmRuV2JheUM1WkVtRDAyWXBOM3NSaDAzSmE0OG0xRXArMXNqS3pa?=
 =?utf-8?B?ZDVjTkQ3enBnZ3NhVW9PSlF3VW1nUTNEOCtqR0YrZFZ3ZVFxeTQwbzcrTWt4?=
 =?utf-8?B?TDBBNmI1WnF0ZWZiTVJGNDlqK2dSRU5ZbmM5R3F3eGpPSXd3SVYxUXJuL1Ex?=
 =?utf-8?B?b25GOS9yZjRSb0FlbG82RXFhYmlYQkZuMXpwNi91TU1HMnZvSlFnMG1zRmIv?=
 =?utf-8?B?SGRSbTFCUHVVZTFQVVhXbUVudTA1WjZqV24vZjVINjNrcFl0Zmd6aTQzMWtC?=
 =?utf-8?B?ZXJkV094NjY0eVNNMVFvVEg0Qk0zUjN1RVBwUFdBRFlmczFIM3l2QXFDM2lI?=
 =?utf-8?B?SE45Z2hibmdiQXVYNFI4QVB0MU9rR3R4TnRoQWRxMWVtdXdTUHN4UU42b3N6?=
 =?utf-8?B?U29UNFp2K1RyRENQM1lWV3IrRnJ6bzE2NjFPamFpUFp6eDNtZ1R2SnpqdHdq?=
 =?utf-8?B?a0pONGs0dUZUU3hveElkZFRsaUV1YmdhTWVLL3RhT1JPNHZnS1c2TG8zV21w?=
 =?utf-8?B?UVo0YzFWK0NsKzF6eUsrYnF3cm1iWksvS2Z6SWMzcW9XRklLYmlRYWplcjRw?=
 =?utf-8?B?c3F4MDhoOGJJT2U0R1puSVYzcDFkUnVOY3F5Wmd6djhJdG1aQU1YLzlMZS9F?=
 =?utf-8?B?MDhUUGRoNzRRR0RpT0tTUUFOeWM0RXc0Sy9uckhCalNzc0NaSXBkd2hqTUV0?=
 =?utf-8?B?bVZwRDRsSEs0aTJvZ2ZLSHV4ZVFOaGQ1YmE0ZCt6dWI2MDN1RDl0ZjNaMkVC?=
 =?utf-8?B?MEJLZkQwNVJQTDlPS2Nha0h2aitvbGJueUdPTWljTkR4TWVFNlI3SEIwTGJq?=
 =?utf-8?B?MnlCc3ZBWUhVdUJ2blZkM0F6elB6dko3dkFWZmdrcFc2cnpLOVlCNFdabGM2?=
 =?utf-8?B?dTg3aFY5cW8wanY5Nzk2c2RtWEpxUVBjSDBQSXhMZjQreUhsVnhVeFNUZEZ5?=
 =?utf-8?B?M1Q3THdLRGdlV1dORkhnVG9VZHNGbXpZam5WVlVKQldHZkdBYm80bmpsOGF0?=
 =?utf-8?B?YUN3ZHB6WDFEYlNWRlVBdzBBeEpDSUJLMjFsemRRVGhXbzc3OHlwUTJmd0pP?=
 =?utf-8?B?dVNJaE9zUDlQMDdvWXkweUx1VlI1dW16c1RURzBKVmptOVVFSStCLzZRZlZX?=
 =?utf-8?B?c0ZwSGxtNS96S0t1T2lzdm5mUGR1bmw0dVM5OGFOVHBYNUY4cldCanJoNFBu?=
 =?utf-8?B?YVJDM3o4Tm0zNzA2YnI1Q3NndGVXMk05a3ZEb0hwN01Jai9yUktwNEJWWWJF?=
 =?utf-8?B?NjBFbk9LSFQzL1c3QThXWFhhNUNxZUkzN3I1V2JNSmlzU1prZ1VrNmlSaW5Q?=
 =?utf-8?B?MFVVY3NzdS9TaEpEQm5kRzJ3YnpLcitaYlg2TWRBZVo1V1pUaGl4QnAvU2JS?=
 =?utf-8?B?RjRLVkIzVEJiOThPSHJBaHAyazJaZTFXMFo4MVNZa2g4ZzA0M3pnMzh0c1U0?=
 =?utf-8?B?WjV3REVQNjJYa21uaXZoVlgxZ2F1b1BLTmk5ZkhTRkJ5T2EzK2xwSnlvRjhP?=
 =?utf-8?B?UFZQcEJVTzd2ZFV0MUhnRWJVelRVUVJiNEc2OTR3UG01Y2ZDZk8vbFRHYVVT?=
 =?utf-8?B?VEx1ajVpdU5QOTBadGxUNHNuR2luOTlqN2w5dGZ5R0tJRWNGUG5BVk5UTGJZ?=
 =?utf-8?B?YjV3VlhhblhOUyt0bTlLOVRNWk1KenY3cG9adFFGY1QybU5RUmVldXMrVmFG?=
 =?utf-8?B?cGFUYTVCK2lFMnc9PQ==?=
X-Microsoft-Antispam-Message-Info: cpIIN7fj+sNLknH7cteswpepMKHL+yAnR1PH7s44vV48cpfVxdZTXhgbMNvlhp4XPvRFYw0adgyEUoG6ZidKO0b2enEPO9doDggxX0+TdiDFhISF2tQ/1VENg5yvF3dL9SxTkbKH8Jdl/5Lq+5K/iH69XyA7undulsh30VHl56XerSjo28WKmVMckC8JwwGshCOhImeoBRRtit08/S5EwJISEvGInZYDOQBuQ/kAjeqEmHQZShQPRqQJtP3VvdM6Mz6xQnmVg5KhPvQVjoHYgr00l9T/X9ffd8TRk/9OJehiiTJEljFAa7GH81PAzak1YHm2WnJRCbyzxtGt7JhpH3WpyBH/VG15V/1LjINbsRg=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;6:0xBWIFDkx9jcgkZtrGyk2nBekZM/iY8GGgoTT6LBStWk5P4dH33Iwr4ciQ7cnIsuEpf9PopBGhMG1HiO+JYJLrmWCkMoFLL+RuOsQ71h88dJBrfeda+PUaDGYxQR6EXsgDKSl7+4g3k9L89wux+Xa6+4PvT12rx+QblWVgF48EQkmJrSIjtmoSva8xAiOBwDcKtY1oHmOgMeNFhPHGn3dMWNnhbB10ofEPlHg4N5U0EADEpY/4DTPgykk6aaolRT/PgvxsHMWhsM6B7c1dU+N3tZVYXd8bPlMYEAmFQAqlmqcuphXvxQ21Dg6e5u6pRh1Z0Ct3TNxxFk7ZQmE/SspZR1LXR0OAJ1OkL1i4Y8pNqSnCZgpI2Lq2J661rvHLg80CwTS0AEt99JrEUsWW9G/YU7o6UNnFmWcidX+piBP3mB67Q0oJpX2xQecZBx566l0+SCq6p9IdD3FKK7lR0IsA==;5:Ms6LmypJx8xS9++yxTyF5O2onQOhufQM9jHXyHbEFuyxAfhl06zEZlHzogoO2+kLrDxNwb80XhqlDqxWp900KEcxloxxfyryldpjIXMDaIiCeLt+7za4BuCeG6IADA7nq0vouz6Lj3BQGYNfqlc7ePjjUufJTZRjUZIkAvGEz7E=;7:xhNodaRKpxiA8+qfzdZQyMHTkpDwTiypsyxaQJ09jKp5kzY0OahWzawIbQ9NV2nKmQv7P6+FYtSRTNwjgDYToUuud1tlWUd+6Qg9MVQOHTTCpiyeJvwkYg0oBFLh8m9QmwP1U2pP3YuqalZQARa57ZVIu8vC04jrYC0fM9GZjMHNCqtZnvMdV3IJvGXTAiQjy48T+bnLaAym95MAZBx2bIsbpAPOH5MXmqJRhV04uESaT6Kv1ZPI6pbUmo0o2PNj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;20:6pVPpVs9K67ASBtJhCeIXPQ17ICBJ77OVxJwhckPkisVUxnAyz/stGeyAXQfnb6QKajUowz9mJtBs6s5ArXjA3xWMKHDcqhjlf00RD7yl/wB00TiarPN8PHin+XTBTO6ENhSZIpflisBITm2S0JyBBSX5gqhPxulgTd8HfjHmvM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:35:26.0298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b7d8d0-0681-4637-ddff-08d622ca39c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.2018 12:08, Miklos Szeredi wrote:
> On Tue, Sep 11, 2018 at 12:12 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> We noticed the performance bottle neck in FUSE running our
>> Virtuozzo storage over rdma. On some types of workload
>> we observe 20% of times pent in request_find() in profiler.
>> This function is iterating over long requests list, and it
>> scales bad.
>>
>> The patch introduces hash table to reduce the number
>> of iterations, we do in this function. Hash generating
>> algorithm is taken from hash_add() function, while
>> 512 lines table is used to store pending requests.
>> This fixes problem and improves the performance.
> 
> Pushed to fuse.git#for-next with a number of small changes.   E.g. I

Thanks!

> reduced the number of cachlines to 256 to make the hashtable size just
> 4k.   Was there a scientific reason for choosing 512 as the optimal
> number of cache lines?

I just tried to choose a size, which is not small for all of potential
users. But, it looks like 256 should be also enough. 
So, there was no hidden mathematics...

Kirill
