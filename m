Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032713AbeBNQgg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:36:36 -0500
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:2112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032593AbeBNQgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:36:33 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 1/4] x86/speculation: Use IBRS if available before calling
 into firmware
To: David Woodhouse <dwmw2@infradead.org>, tglx@linutronix.de,
        karahmed@amazon.de, x86@kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        jmattson@google.com, rkrcmar@redhat.com, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com, mingo@kernel.org
References: <1518615874-13806-1-git-send-email-dwmw@amazon.co.uk>
 <1518615874-13806-2-git-send-email-dwmw@amazon.co.uk>
 <6e3610be-cdcb-5c5c-fecc-7c41f2ebda73@amd.com>
 <1518624677.12890.143.camel@infradead.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <33d227ac-7723-5e5f-c299-4a44daa427c6@amd.com>
Date: Wed, 14 Feb 2018 10:36:27 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518624677.12890.143.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:3:c0::34) To CY4PR12MB1143.namprd12.prod.outlook.com
 (2603:10b6:903:38::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf51d951-6fa9-435b-a9b6-08d573c91a2c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1143;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;3:Y1Gnc50C75K2ILnbziyz9ZK3txzFKxw0qYiY77WCyYGQD9sufopdxNISqoM5uyWzwRR5jZ7uEOnAl10FjWMYsAJTzs5Q9tiBvktzbyyrT2YN57Jm+bY6mCr8ZHTAxDM9gJit3EZP48hdDU//2aP3lPlITOL6JdxVJsky38dBZ5oiUcnhKLQHU3ZRs1N8WUiUcpGRUdPKD3IRSvv3kr4gTQi6ioXkRVqDJ4RW8fpdG27v2R1HNRh1g2n6yTIibmLR;25:a5edlVen1/YQPjQI2lv5F6IyVIi7I+LrtDzvaAsWiTPfVjPjO2ix7JlnRECwAUPfYfw3O67VsIdmWjRBmLbSNWnQlOJIYg9UDGm5BIRebW0Z+yGvU6ZorEcLHJA5BiS2wZo/S1QyASmpjNkUt8eg6USstC8OxsRIM3aiJfTS3zc8S6kfIt5i/mZcyljDW9kWk79t7yg6kf40C4Q3SIYj0ZMM0Sx2RhzqBTJ3elCAd6lIjV3zgPtDhArcvNRKG6VHHYz3Cfx1Qxi5IiGg/QS7K0BHbjqDaXTU7NlhGnLVzEiDuiFkwNCKtKoWEUt4kAWyJRBUuZ23jeN7O89rR3C3cw==;31:JFHdvWQYKFUN5oZ0FgA9yDhD5fEKs+J9pWxMYscYWdUQ5oxTmIEBPhK1JHrd/U6BdCashJEVllarocMKKjns22BBesby29ilEtRf2abIl9etYgIeYZjEDhYLAEyuTuGkdLN/Q81Mdcv9yY/dVM40R8Be9ND7dqxzwRIRtiv5iuXp0hvOJt6dU55XX6a+huC6dY9n9/rEgx+gNX04kess32A5pp9142c82JCk9MRButI=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1143:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:brwljmZJBYS/K/LW7qm7VPhC8Lk7wpZzyYQC8eZNGXEYkkyR/iwEfvJ8xHRum2wKUh0uIeFdS3YqOk/fl+HjvUchztaZAnzsurpzArTPpKLRkU2BnwafXB7kXoTD7bYYxpS4iSe0eT1S39H6pHWeis3+/IgMNWHHgYdv0JQ9lkXTnzyjLau8H/No1Qx6j7LIeESnWLgAoCyKp0w3nWYRuIGdgZZZSpH8qzVtJm8ik4Bqc19+/OEkeYd0LSwGzPQSIXS7yF7iXHWo4uiML710274OvI5iUxovxbcS3owaphg+fIGzklnjxOQIRYvjKMZJQyRlzd9MyEYJ9LFI9hbS8h3N2DoDNVn00PBLwrkIpbUNavBp6fQCo70BX/RIY1p+kOwmNPSVH6cbk60pB7Lsxs8C1dpcY+LwbuFMATCqmCfcZM1PmpCh4ASn/tZIy8h6XZK11QD4pfiSypfl685OGXSj28zKzuGuUIWxdhTG1vVwkRdSpHldd25k/7pNmIIZ;4:CmcjgPDv5EbZxvPZY+U2RzwEDqx91jtJevotxnTvRH6GQ8DM601Qsl08sT6RxVKth1+xSPQrqOndMqKWMAZg6wVMoe05B7ZJHJVJB7NKid2kpJTP0e7T4y1MZGXCPmZ5BMnY4Nb1Z7SvBI+CTPq73G02BFZibfqFq8k6O20kC5D13m5t+8a6bqCEk5GslxOYYjZMx7Ik6RZWBGIU5LuKJNYAAuM5K2O2ZMMo1T/zMELn92t6JFbA+FjnJExY/s2QE6LQiyR8tfX/8gNMk2EJoA==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1143083CEBD6C979BBB5AFABECF50@CY4PR12MB1143.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(944501161)(3002001)(10201501046)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1143;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1143;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(396003)(376002)(39380400002)(366004)(377424004)(52314003)(189003)(199004)(31686004)(47776003)(68736007)(7416002)(58126008)(16576012)(316002)(83506002)(65956001)(36756003)(66066001)(65806001)(52116002)(86362001)(53936002)(3260700006)(2486003)(53546011)(77096007)(386003)(6246003)(25786009)(6666003)(23676004)(76176011)(26005)(2950100002)(106356001)(31696002)(2870700001)(93886005)(6486002)(2906002)(8936002)(65826007)(5660300001)(3846002)(6116002)(52146003)(229853002)(64126003)(8676002)(50466002)(81156014)(81166006)(7736002)(305945005)(72206003)(16526019)(478600001)(97736004)(186003)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1143;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQzOzIzOm9Hb3FEam0xazdVTEo5aG90ZUt2MUErbllL?=
 =?utf-8?B?Mm5kdGc5UGp5OEk1Si8zemE1ZmZkcE9pK1pBVkMxTFlndC9NVFE5alI1UHBs?=
 =?utf-8?B?ZXFJT0hHOEFoN25BclQyRksvMVkrNU1YTkk4SUZnd09iZzV4dFdNblFkOVc3?=
 =?utf-8?B?bkkzbm10ampFT2ZSWVFBMEVMUTY1aWZRcXJIV3FneHZPNzY5djdiQjVPRlRT?=
 =?utf-8?B?QjVMdUdKVS90aUJIMjRQU2tQTCthOXBPMysrUnk5V0lWbWRmbmFMcnI3U2NX?=
 =?utf-8?B?RFVDWDdraXoxY21oRnBhWHEvbzdzUWVpVGc3M2JFTGhXTEFOQkFFMHNpT094?=
 =?utf-8?B?dGk5MzJzMFU0d2NxUklQdGZnR0Rlcnd6SkRlV3R4d3UwSnBTTEdnZXJkV0dw?=
 =?utf-8?B?eHRRTG11eXJESkcwUkxqMVlhRmk2Q2JGN1ZMUXQ5MGJCZnR2SHMyY2RzZHp6?=
 =?utf-8?B?SkJLSU5Bd2JPMm9YWkduTmF2TmpmMXpyVlA5ak9STTlROWxyZCt0YTc2ZU9K?=
 =?utf-8?B?dDlMbzlyWVJUNUl2M284SlNQUG13WmZjcW1PRmU0cVRWT1NMQjVYWFNadUpw?=
 =?utf-8?B?cEphS0g1TDhtZEtybS9XUzJOaUZ0cGhEY25oTXU1cFpZcGw2SzZvc0h1RmhS?=
 =?utf-8?B?ZVppSEt0M2FXenpSY2RSZ2tmblIxYStST2FmM0F1YUNONWxLQVAwVlZXWkVE?=
 =?utf-8?B?MHI4RWtFWGRJU2FjOWMrMzlpYzZ4bXNkQ05KZHRRVHJlWGprSnlRT0pJZG5B?=
 =?utf-8?B?UUNyLzhHSitLTlVtTjdKdzAwbHJ4VzAwbURnSDFQQlBLWTBwcTR5d1BaSlNJ?=
 =?utf-8?B?aGdoL1hkVFEzeDNGK3c5V3d3QU1oRTZ0azQ4aFNSUVRXQS8wQnpIcWtIUkFY?=
 =?utf-8?B?STVYaE5aZHRDbmR6YXlKNzlZa2hoTloxZXc1cGRNNkVNQmFqSEVLNndUb0Z4?=
 =?utf-8?B?ZG5yNitDUXdoQkhpSmpiYi81WEtKdlhKdWwxT1dsMHNHcTQwblF0bW9jNWYr?=
 =?utf-8?B?N1dJQnBpQi8xa0NXcFVldklMRTIweis2VGI5bElBN3NTRVdWUDJWYmM3LzJy?=
 =?utf-8?B?MlI2aXE5ajAwNkpia3R5RG5kcnNlWGh6aFo4T2RNLzhYMmN6blpJOVlSWWd1?=
 =?utf-8?B?RllURkpkNEtjVnRLYUNJb3MrQjE5cTB2TEtHNExMQTBTOGxaV0tySlBia3BZ?=
 =?utf-8?B?RDd6TGFXbVlUakNnWU1GS1hUUGNFVHFwcGN6anJnSzcwTUFYKzdiWnJJemFT?=
 =?utf-8?B?eDFiRnRKQXpMaUFzdVE2M2pDdWdhZk5LTmRuaHd4QllHdmo0MkxITzBVZUpG?=
 =?utf-8?B?eHpZcEhzaEpXRWovV3pGbUlocjlWdHBFS1F2Z0NKZWZOb3lyU2YyQ3dYVk5J?=
 =?utf-8?B?akh6WkdrTU9uYjdRVWdOMjJBUFFsbms1Vll1eUJ6Ym02VWtvb3h0a3FhQ1hP?=
 =?utf-8?B?OWQ3bEpDTDA1QStKYkdDZElXUi9jRlZHUnlPM0QzMHI3RkJsVitBSmxzSXNw?=
 =?utf-8?B?TlpSRklIcEdGdnNjOHgvVVppUHBwSzlUbUFEQS9JLzFMOThITWswZk9nOExx?=
 =?utf-8?B?Wnd0M1ZCRGc0QU5MOEhudEZoa1JiZzliemRXT0tTU25aZ2g3SUhER1FVSkw1?=
 =?utf-8?B?Q3lXMTk1UE43ektMRzJtZ21iQjJ2YmlWRGhOOXZEVzZEZGQxYzBaZFliS3dS?=
 =?utf-8?B?cFlDaDRpazZDOEVUeE96OFdXN2V6czYyK2JFMzR5ZExVQWZNOVNXZ3JleXlF?=
 =?utf-8?B?S1dhUzE4T0R1V0QwdXplSDlpMnFaK3lMNngxZCtNZXpWakpZdkp1Qmlvbjh4?=
 =?utf-8?B?OUFvUXI1M2tNWklLcEt0Zmwxd2xaTFROaWt4WnA2N25ydGU5aEQrYzJUOFVU?=
 =?utf-8?B?cmlTcUtHNDhmcis3SytreEFBSStkZGVTV1FWMmJiMXZkRld6bDhxcldlUDZ1?=
 =?utf-8?B?L2RvaXc5ZFgzZS83eVI4MHpKNTBHaXZkdElYOFdqVVZidmI0UHlkeUZhMGZ5?=
 =?utf-8?B?Tzh4MmVmRzVPMmdVNkZHN2FUVG1zMFBNc1hMdz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;6:b5QCxxip7G+Y4EDMyPMZ1ab3yk2upGqGqcnsvjdRq1VcZHslfjp3P7B3o7XFvLdbX9+JPRVFYvIAg+/v6PoelM21+0jrx7qGsQzZQVHKSYmAxFhk2b8qIgl2YCHFxSoGVo8cQk4/kYK8Q4euigvngIe/vsAFtjdsgwBlIKz/EhaHqneffRp0tkLc0fRewpTiAIDHv9dSpLyChBLepiyyPvYhHgCbkxLvU6dA0Ep0lOjOqCnrstDuK9pBTTmqtSOQV7WGwT6J0wAkUxaFLd/tUNElLhS2o/wewiGNKgHi1kfJRy0sWOkpmASECwBXYrddhFz2RjmGh5e+cwMFs8GyTSDfpN2hASuDoKyfGjGuvBY=;5:GOgNaQKGJ+UI8xMZDOk3S/X3Q7jjj9H3eVZBVrHDiFj4o2Vsj/PPJnUFhmyqkYTF9ktQQ9eakAHPbzPRiXkSost3hvch0MMP3+j9QQuJW3wsXISzLWV02I+2iaDP+pIf+PaiuVpEqzdpccuRo2f8CHsAgsQRBDoAeWLr4B4ssI0=;24:x3T8fh22XrP/mFFdYvZdt2K8ynHn3svtJrcSIO0oAG97ID562QemE3V8+ChdhVmPToDPr2SqJ5leQxXFRCGuTD+XsxKPHNrrf8rKvQ6CJFA=;7:SmStmxJANGXG/g+mWJpBQ5MK0niXqN4X2gfpOOlsiryhYhIgYLM+PY/Cl8BOqnLYl+HoB5Vv1E9HURiosDlQR0mcH5W4fcrkLuEHmiPrGMn9RVARtmYpe767pIshJmBGKTl/9WR7+VKfge9cocnRZz0Th4YMnBZbdew3HP7KAbeGs5SLYX6V6BS9dANFfs/Rmlgv49/DCcYCQarNsrf/v2A6nUuEv2iqFetipsd2o7QOrIASJqxusam0wldoT7Za
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:TlLuEzUoboB5nK2ENOAD3EbYvMSOd+dibefvk/7sGXJSFnbbfnUz6srKkSVAWNoSQ33PoypK4ZHIzPNRYf7d7gvo3NQWes+CGUlWAPhSVimW9NJZSIhL3lGV68rwMdSVR9OaYpduSUs6GtVXRJYzOqv/+HLsILBaKRXwmhSv7vTDtVWqYZf08b+P5yjgF1vngkcyrjjomTWuViYZvpTffXhv9mjli4Ae/H6Tvy53b0Vr9lEw1klob86+1SrqsDYw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 16:36:30.0360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf51d951-6fa9-435b-a9b6-08d573c91a2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/2018 10:11 AM, David Woodhouse wrote:
> 
> 
> On Wed, 2018-02-14 at 10:07 -0600, Tom Lendacky wrote:
>> Shouldn't these writes to the MSR be just for the IBRS bit?  The spec
>> also defines the STIBP bit for this MSR, and if that bit had been set by
>> BIOS for example, these writes will clear it.  And who knows what future
>> bits may be defined and how they'll be used.
> 
> We don't use STIBP. If one day we do decide to set it in userspace for

Right, I understand the kernel doesn't use STIBP, that's why I mentioned
BIOS as an example.

> "sensitive" processes, if we're done having the debate about what those
> are, then that seems unlikely to conflict what what this code is doing
> anyway, as we would presumably *clear* it again on the way back into
> the kernel.
> 
> I certainly don't want to add a read/modify/write cycle here just to

Right, definitely to be avoided.  Maybe the value could be tracked in a
per-cpu variable so you never have to read it before the write.  Just
change the bit in question and write.  Not sure that's really feasible
though.

> cope with some hypothetical future use case for STIBP, when there would
> be better ways to cope.

Just putting it out there, no worries.

Thanks,
Tom

> 
