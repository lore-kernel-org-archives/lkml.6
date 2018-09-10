Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBF6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BA42087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uqP9uXmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BA42087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeIJRWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:22:12 -0400
Received: from mail-bn3nam01on0047.outbound.protection.outlook.com ([104.47.33.47]:9240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728066AbeIJRWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7uz8TaHK5jJMAcseInNvK4Rg/tTd0JoJIbTWSrBzSQ=;
 b=uqP9uXmGge57PKyvS5sL6xIZ6D1YZy0oOCGslYeIXzFlM8qeJZLH4uv3NZfmsPEPjlIDuDiOxWkk8Qe2hrr0iUnkG7pF6rAJn7u4R24eogSTNePgMYG7bAv2u2/AwHEsSanLwvvMYAlzfZc/Fvi+bDe8IasDqo98OORjUqCM6L4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 BYAPR12MB2677.namprd12.prod.outlook.com (2603:10b6:a03:69::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 12:28:12 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 2/5] x86/mm: fix sme_populate_pgd() to update page
 flags
To:     Borislav Petkov <bp@suse.de>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-3-git-send-email-brijesh.singh@amd.com>
 <20180910113645.GB21815@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4001638e-6627-7d42-2e72-21c48484022a@amd.com>
Date:   Mon, 10 Sep 2018 07:28:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910113645.GB21815@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN6PR1501CA0002.namprd15.prod.outlook.com
 (2603:10b6:805::15) To BYAPR12MB2677.namprd12.prod.outlook.com
 (2603:10b6:a03:69::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c6b8bf9-f822-4dd3-2d0e-08d61718e06e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2677;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2677;3:96tggPzh4eYDUE9TnqfeR1LEzHvKN3XEGeWXoJw9gJZiE3pgzxHXkgtNOI9ms6zVYNTsMgNyiICLuFbr3g1NEP0P8cbLqfShqmEjB/8jJr/hIWC2cfBBOXDmRRkGAq2UI84ey7GYwyFUI4CKRb30bIyh7Oz21R2ymsQoDUidHZVryfwHSZjM4NyY8xnhY98H1xf71Zybm1KXcGtRJyuJbnl1HCpQe6F0UGVQHfNh1WWshShbeRDhuv0zIEzbCnao;25:xjfFJGotvpmXWYpn224VsTnYu1mGsZyjdxyfh96yF55xLIohm64V2CU9Mw7JoCUMflapoed3Srnr8mGLQcuNxXrRpgeet2YfSyPe4ioGKGbgyawAw7celEF5DOu9zn4FeS07lfT74gnG1/Bhmryv36pOFGrwz+zqs4G717BNnyfG2ILF+BfSvkB1QOp2oVKhDDUdu47W6CnSiu/wydNtzWqdYstYzlW4LPq8n3IJ3iZdG0/q7c29DvKD8vDQCSvMy5UDwTFHo7DBxHJMt7OCjhJyd+RxLjPk3Fl38gz/pM+7Owq5vs8JFmHeYD25XPz+zgof7lv38yVXaJ9gKgCBlg==;31:4yNQXJ/JuKtEHa1sbXhw2TAA5YHly2akXiFUt73UOnEvDeEamGPZ/8Bli0lXZfUirI+AmNXFNJCQIfgRJg904bGrxLeOkrVE2zzJK9SLMN/nGOh9XuJBcVGXdYf+5L7A0jsZTQEO5CMhgQsTBVg27X0+q2BJou2mVIITx+Ek/VUHNgBMqUaq+C2o5+fLx4ifyx3q+qmM9oillPxC0r3XLyz4IByKeGXS2mn98pjWyOY=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2677:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2677;20:P2BAFBtkcMgPsGUDhYjuX/b+K7H5HCrQx7l+GQfzb30SOwIMtzbNvnl3QvQWWneH8IV2alOdG92KX11CyrfYCowzsUP9D+xxgW/LTWKUUujXXHp56EOzOQbWWOJtDnjznBOxFsrotdt+6exJuVOqkhAiVguJY7itaYLdvMsBctxCP6+h6b6U5LiSZK+xlPbZAxF7Tyz+tiLGO1AFT08cxQbNpsHQ1FKo0y8JxAksFNhZ3UcoTPOVp0wrMqd6gDizFgytpZ71hrTmUE1dHhQtvbYc5ZC5es3qONEcI556/a0UpepwKYaFKvBBzGo+kOGKTzZzmGx6ST2p33neFz4umeq3SSQ0cu7hmdihS1yJyvNRFSVPYPdAvgCvTMn+4qQCNcCwuSm97+xtbuttYcdSWMKc4HnAjGtIxcYL93Zs6LxPGtu6ZvhN3vpX+8evhHhRJKLc8Kk1fnGRM/QMFVSAUi9glXepr/hLQ7aA1aO9LsZhTUyc8wHlqP70EZ6nHmQG;4:PmvRZHljRFMdemSROJNkCsKDHdtQT5A1eF9dR1feXHon2kaRRwh/ixBWkSQsAZ6rQajuVGFKiEVYEFELC4IfgWPH+hZoUkZwv4cL7ZlcQLHlwa4h4XgENHk6UWkQNkcE2NaZDHYv+enK/q8rln7JBB55gn0K631695CaHqudJOTobFSlBEKv6x0QiTja+MtTM7pGI+Jg8acx0vz+AgAG2XROzumrujpsSRv5aI9Ys6Tq2RYx+Cr28cRfkHBnJctV4n818jHWZDCUU3VZpEB0RANeUSTvCib/pbYhcLV8AlVCpfvXKUupyP9xBDI8WVSk6R+uZnIbTN3Sla8g4IS2N8cN2hUOBSlpLkXkwuLHknEjHi4Lxa1JC+qZOI5x67kn
X-Microsoft-Antispam-PRVS: <BYAPR12MB267794BD9F1566CBB6881356E5050@BYAPR12MB2677.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR12MB2677;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2677;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(50466002)(2870700001)(68736007)(81156014)(54906003)(53936002)(58126008)(229853002)(6506007)(386003)(3846002)(7736002)(6116002)(64126003)(81166006)(6512007)(478600001)(47776003)(5660300001)(106356001)(305945005)(26005)(65826007)(8936002)(86362001)(14444005)(31696002)(8676002)(105586002)(15650500001)(66066001)(186003)(97736004)(486006)(6246003)(25786009)(31686004)(6916009)(956004)(65956001)(2906002)(65806001)(16526019)(52146003)(2486003)(23676004)(6486002)(36756003)(446003)(76176011)(316002)(52116002)(53546011)(11346002)(44832011)(2616005)(6666003)(4326008)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2677;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjc3OzIzOkVSZVFRTTV2NmxXZStGNTFsQjR0aXpwNStk?=
 =?utf-8?B?VkZiQndzVDlRdE4xWVowOFhGcVZlbnJSMzlFMlNhZThBNnpDSDVBZkdEZ05K?=
 =?utf-8?B?YzZQSjc0bU1IZ05oU0NBbEEzN1dTMHFzbEhtR1BHaUtrRWcyREdkMEo5eS81?=
 =?utf-8?B?Yys4MDJ1K0lGcVVrM2FhRUpzRi8zTE1McWJib1VhVnJ1bEpPWGI2VTFad2dt?=
 =?utf-8?B?ZjhyOHhlWFVyL0xyTXRwTnVPL0lOWW5zSnJZSmIrbHIrSVpER1FpcmNwdkp2?=
 =?utf-8?B?TTZ5c283SDU3aVNQZ3JWQ0YxeTdoaG9kblNVNytTaGxadk4vNjlXclFpR293?=
 =?utf-8?B?MzVRSWovck5lU0VsY0NQWEwxbWdBaFVHcE1NT2dPdHZSaFNXais1bzlwZEk1?=
 =?utf-8?B?blk4cFRrM3dMRVdqb1dEMDZZYXFmVS93SnJlNVBtS2dMQ3hrZFhJWGI3MzI1?=
 =?utf-8?B?WGZ4ZFpsWStZeHNqQnVqN0xmL09TNWFRQ01MbG5DKzlJeG4vMFVEc09QVVBM?=
 =?utf-8?B?b1l6MnkranhhcmxZRlJFZ3paMFJSSTFuOE1JdW80bksrdllhdndEMnhVQy9G?=
 =?utf-8?B?eFZNYkwydDZGZDNTRXlkcFR6SXJmbndEUjJlR25vWGwrSU1VMGFCZXdZbE80?=
 =?utf-8?B?NDVXUkhyQnBMSlN1UlZMQnU3K3pwU2JqSFN1eC8vNkhkVHVNUDFGNlordkRB?=
 =?utf-8?B?RWdtRktWNC91K2p1OGdUcU5qNi9JSzE3d3F5SHNQUmtuRTIrZGZmTC9kOUhr?=
 =?utf-8?B?bmlBSzdVNks4RUYySTNUNzFDMnNwb3FCVThKSFJQV1B1WHlLZ0UrY0dVU0U5?=
 =?utf-8?B?cjFqaS9MVkVPS2lTaVVxbW5oK0tKNXdtbWROblU1M3pGOW5qQ3FabUI0Szh1?=
 =?utf-8?B?b0FZZ0l5YnNRdDlFcXp4ZkhwQjR1TWQ4OHpVSmJvSGhieDRwdWdMc0pSTFpT?=
 =?utf-8?B?SFFYVFlNb1g1ZzFuaE1JcHdzbmY1Z0JPcFpnR0wvOXdzTXR6ejZuYU1oVHc3?=
 =?utf-8?B?L0ZKdXlUclJJQk9XbzllcC8zVzFEV09VYk1LeUZhWGU3MEx5bjZWVWdWeFJx?=
 =?utf-8?B?WUxFc1JFMkFhTDVrMWJkQjhmalZ0VldVYUthVEFrd0Y2UzM2NW1JdEVvaFgy?=
 =?utf-8?B?VTUvaDFNUnFsRy9SUVBuak9icDFSQkNNMHNWNnNOY1hSZU5EZUtPMnZUQnY1?=
 =?utf-8?B?NmpkWENFbjI0RzhBWDdYd091dWZiS01LN1g2VGFoTDRMYVkydGZJSDdPTjFs?=
 =?utf-8?B?WVp4NXdCM2VKbk12TzR0NjVtVi95OGdwTksxcERPbVhlT2ZKRkMxRkJVeTgy?=
 =?utf-8?B?Zk5OcmVRbXhteFVDR1l2MXg2eExuM1hjNlhVU1VjcTVLclIxdmxmMmgwb1l1?=
 =?utf-8?B?T1RjU1dyQk5SNHU5K05ob2xldW5YQ2hqN0hHMmpWd3B6dXdrellobjFGb0lp?=
 =?utf-8?B?clV1TkR4TEFYS0NRNmVJYUs1d2YrZHdrS1RmZDJxWEdJakxCZDBsRkd6bjhm?=
 =?utf-8?B?Y1pUZTFwcVVoZEF3UVJic3ZrbUV1akNnOVJvMC9MclNEaTM3MStTSmhaSjBh?=
 =?utf-8?B?MVFPMVVQc1gzbVdFcm9UK29zRWczL1Rrcm9ZMjlTbU1vOXFuUmQxak9Ccndi?=
 =?utf-8?B?cWY5S1VQU1VUY0tBOGNxUGZwa1BmRGc5dm03VXhsMTBiQ0VMM0h3d1hWK041?=
 =?utf-8?B?cENZczZXK2xMR0E3N2hVeVM3WGZselhWbTNZR1lOS2d1blFoOWlyd3JrTE8v?=
 =?utf-8?B?SXgrWmVGT05EUXo0MWhmZW5DRUhPd2NYaVI3R3V4aHBkNVQzdnY1WWxseVF6?=
 =?utf-8?B?NDJnektGd1poeXNVSmNCSTBqTFBWUTNYbTg2Q29YNk1oWkQvcklJQTk1NDh4?=
 =?utf-8?B?SFB1VVliRVBSMnJpRDVtZ1JZK0J0TlRvWHZLNW05L21rL3p4UzZCMHZZWGN0?=
 =?utf-8?B?OGtCRmUxb1pqUUNrdURnNFlTTklIcmIyZENIOCtZTFZ0alAwWjhDR0JiNFp4?=
 =?utf-8?Q?4Bt/2i?=
X-Microsoft-Antispam-Message-Info: dVcoaJVr3I1P9s4wAVEtcg0tK4q/dNX8zszXrTcyKQfDyFp26rozfgxqi9ef9ISf36dqe/zJhtpLnte5kKv8FM3MUwYoTHIp4tveZaBMFFlRzuW5Ab8tYLA3mVZSqN4jV14TQJQI0VhbiE8dUM6PuFupsNPxpyK5hJtbxAw/F2c3mCKuDTezH8m+iUQusjf1Wsh1Zli23qOSkn3X5oHyCe8EPx+lzqI19/KQ1aIBoM6QGg/nfKn4VqJwkBREa9LL0eJIzWb4robeCirm3UAihXkKMTjmPcg1EQQw6wCUty7Urb3qNq23BvoHLij8CPXnm1oDkSz06AZNFaNOLd32p93R4Sya31CLDytujmkBmY4=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2677;6:1xd74ZaEJqnKrJ91a9Xm6mqZNabmRSmOsEZE/fZ/MaivFukBD8dEsnuemO3jwlpTxoZNTs8z/NXukShGAXi+AjTAK5z6FEnz6TAmoI8AT/CK5+mUYE6Qmxj/OX0J2YYEUgi8q+LElbifqecYi0O0xC0f4Z3WZ4Gf3qYFRoczXas825n3+zayCxCTrFy0NhTM4/0XkJtKTjcz1shplCGRjjpQlMkRITAWly2+pPBSJR+zSktwnAMbwqqauZhUkzpRKdJm1iaYRaK8zHyP7Vvdeea1KDZWdSM5tboG9ROjHNGcpQb1QK90RV2esIngfc/mS0Ebw5QMhxCwcvD3fqFRgVMJqwcbemVG2Yw287qACmjUQrNi7Evg6iZLxeLx4D5HwszWrmGXR5EKv0hOLErzgn93GUz6wslJ1MVfCFZbTosDDQutVdM3SQTAsDXj1JmGKSc9sWSMKNu5IRrozwri4Q==;5:oJm2GFwrYY2TQdZfjmlCpTGN5jT8nF8ETf35lL2wMmd39b2KIPJZVEgeDZy6rzmXH5Ry1bW9DNakBYYfBhfElOfkqueEAUw+XP8HCHb7+beJZzFpZHmPgoTYe+6v0k/2IiTvmgizTOggdQIh4L7cWgK3dv9Qh6AIZG31yf3Qg10=;7:50Ykw72TikDl+oWnHRYlxYIUqna7fXa1qIKywVErF0TCIjM2NZ8X0zuLMetgalWjNWs0CseMSF3K3JoULTscbJtV5v1+KlGZvObObPZFxNRszfHr01kIAKl524YWWSqFXLuQzty9uP4vxMHJ9X8hhY1TZnLS0m6rsY1aTmumwZCNkg7pI4LbcWMJRTU2aH57rQmZlDhCCdwy/iKTW1SmfwJFvQ5xgnpdv8FEUv29AWHQ9Aey2Ahh1d1perg7eleU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2677;20:kfFk85UNWIS+fDMogKaE0Vz94j4rfA44kiQDEopfHL0WlTF8qQBHg/c4ha0SbRZffO5A6e1cM/x9sqFmNgrYEW+EcsS8d/79NfcDEZ0tt3TvfwE+q257+tAUIO5eVQkMag5A3eCZisCKJ8XYaBjH5yczKMUVSqP7G0ldA6VTNbf51VgAvbKFA6Whc+mfddF0jzD7fjY6z6/oebZMGeiBUzghL8KtWycEliO9CLopIUw+I9zPAUoAwB+YNTCy4z0N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 12:28:12.2358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6b8bf9-f822-4dd3-2d0e-08d61718e06e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/18 6:36 AM, Borislav Petkov wrote:
> On Fri, Sep 07, 2018 at 12:57:27PM -0500, Brijesh Singh wrote:
>> Fix sme_populate_pgd() to update page flags if the PMD/PTE entry
>> already exists.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: kvm@vger.kernel.org
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
>> Cc: kvm@vger.kernel.org
>> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
>> ---
>>  arch/x86/mm/mem_encrypt_identity.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
>> index 92265d3..7659e65 100644
>> --- a/arch/x86/mm/mem_encrypt_identity.c
>> +++ b/arch/x86/mm/mem_encrypt_identity.c
>> @@ -154,9 +154,6 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
>>  		return;
>>  
>>  	pmd = pmd_offset(pud, ppd->vaddr);
>> -	if (pmd_large(*pmd))
>> -		return;
>> -
>>  	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
>>  }
>>  
>> @@ -182,8 +179,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
>>  		return;
>>  
>>  	pte = pte_offset_map(pmd, ppd->vaddr);
>> -	if (pte_none(*pte))
>> -		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
>> +	set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
>>  }
>>  
>>  static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
>> -- 
> This looks like a bugfix to me and as such should be:
>
> * at the beginning of the series
> * contain a Fixes: tag
> * contain Cc: <stable@vger.kernel.org>
>
> Right?

Based on your advice I  was going to submit this series to stable
separately. This particular issue is not affecting anyone right now. The
only user to this function is sme_kernel_encrypt() which never updates
the PTE/PMD entries.  I can update the commit message like this this to
clarify it.

Enhance the sme_populate_pgd() to update page flags if the PMD/PTE entry
already exists.



> With that addressed:
>
> Reviewed-by: Borislav Petkov <bp@suse.de>
>

