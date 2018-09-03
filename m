Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE96C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291AA20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dVvUKlDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291AA20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeICTRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:17:42 -0400
Received: from mail-eopbgr60104.outbound.protection.outlook.com ([40.107.6.104]:9266
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbeICTRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+M2XEA8GSD1F52ybY+wR573ocbOTz8G/nclDVKA7kI=;
 b=dVvUKlDwH6lU/UgPwkEiaUstIJUhSyCHUQi0T8RERaggr+M6D+YXSo0lxfqsaW4HO/26k6fqOwOrz7r6WrVu6qdEMOC53TixVwBjonv8dwGj8qniQWNLKc3jB0Od6qLM4yB4SY1kP7GdKTDLedxeR1E62Ci1N9sKYgCynPyehpM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 VI1PR0801MB2029.eurprd08.prod.outlook.com (2603:10a6:800:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Mon, 3 Sep
 2018 14:56:59 +0000
Subject: Re: [PATCH net-next v1 4/5] ipv6: enable IFA_IF_NETNSID for
 RTM_GETADDR
To:     Christian Brauner <christian@brauner.io>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        jbenc@redhat.com, nicolas.dichtel@6wind.com
References: <20180903043717.20136-1-christian@brauner.io>
 <20180903043717.20136-5-christian@brauner.io>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3fa4543b-f294-f228-c800-38e00a43a2a8@virtuozzo.com>
Date:   Mon, 3 Sep 2018 17:56:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903043717.20136-5-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0701CA0063.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::31) To VI1PR0801MB2029.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8326d79c-bc45-47d0-c451-08d611ad8131
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2029;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;3:Wg6i/tIGAD2U6guFO3pcJTV1WlS8slZLpGDvfJoHc1BsRlVnqB9hylTlTHVk6BVF0Fv9iDLM/Xw0WsCReoGCDs7kV0ykOmg3MAZzn41zw4ikOKj47/+/ypvwpgBVive33M/wo6MtT9STAH3L4mTzQLfwslCIKGHl/j667Ew8YL0NUrPtGHKf9tewi61F6l9pmjPsEoNVS+X7NE/o/2yui1Kxz0/OdDOhE7CTVrunJPYzheqkkAIDuX93Ka7fe3UQ;25:Cy0Bm5P8OglYvkuC7e9Ky6AqhbcnnmGa93TOenhU/+UqMCZvW2D1HZAZt9Az5UaM/mTZajCd7radyJ3FAanZtnJ3BJBRGMoyEv3QToA4AsfZ03T7G87IHxXwMOkkGZlpLFRTOpBHPjlTFYMJLW94Yyf+vrpQdGJG20nQMrJ8WJxlUtTJS56Pg2BVvd1yUfGUEq/Y/F4l6uKn8V8CCCw6Nit70pMiUf4KymfQt9C9JsSqy6TepYGWhFT8uSHgFLNV4m6GYvMqPpR7XT+UIhCdFOCEgLmume6brZXiKNQfBFi3ItiqdS5GwhFIBEDcRJbgzB3dbk4UlLyW84ydGLuhUQ==;31:AaA9QJ184P7I1XS5BGCXR2tFbkm3kDGh4ZcfohFAVpwvShEd/rWxklsjdJFQYCewtDrNRGKoxUfYZzntLlf3pN0AsIqMwi48IVGeGyav9Z3CYLndEsPUKO+rVuHUAhZMZKRX478Op1Q03nsSkcQ67sFl1Kn5OejvpUAPgaOuUK2nNOx/Xif+imPX2n30UFe04ApQz1h7T1GSq1mqm7MD3wy4OcFPs82qGTWrbLvy9aQ=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2029:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;20:vLMI6M8ZSdqlbOqlT9675PRvFQUB5e27ie4L4qhUzomx8qRTQVnD2xC3zgs5FyM3yB9N0Xfq9ve8r8IT7VY1wYDGRsUBYhoZmV7Z/5YO04VkeWNwkmdPChzE/ONVwn6nF9MXhmQyetPjTK7jImA5lOV8Y93J8Brqbv+DN7w7FaBsX12y8TkkgUdqgZnE51R8Ntf7UcwZG0Gt1SVvwG0C5hSHYTJn9cVdjjI0blWLoW1ipjgfFr4JHnMk59Lc11K6M9atgr6815v7rxKYeCTJ//GbzJgfAcxUWBch6hvdTz4eyYMJR1bUoov66N9xlQGLktxEg1l1nUwYDj2SSCcxDyks5y0bZ1HtuNMyxjJ3D96eqUo4tMJYi+MO6ZBGO5GiwScmlt1Xg5qragWeVCXEcYSdJ+Ubx+GMmxhXNHk1BMTCLZmuLB+b1k3GVZJJx0ombNrjaYIly3164wBX5bvVoc3Dwy1jut3xX31XQ84+7dm28K4nSXMaKl86RDqEIIcT;4:B+ZFLntRnlJDJ6T1XrW0laKE852Xx3WO/2UioBdEb6TcZXvGxrAoKQJungNKjGaFfK59Qn25TTh/an1AkIJrDLWxIPoynnERUL8lS5qoBsgBzM6ROffqpdJprsrNTRk6vMLHb53BwKizov3DwvXalkBGEgcq6ypPa/of+IFGjf1sMuOAO49j0AHwgK7YHNoFGf2O7q7KAqY654YgM4j1odiiS7R5lve6FGQirTxT/5najb9kT6jVALZKdd32fRRiEFkzqTZMNvWy9mQ7i4gmkc+D+dwfRxsfrdyMN9T6H+dIhCgKgkUgSzYExCVCohK1
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2029E4624B1EAC08879FD9E5CD0C0@VI1PR0801MB2029.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:VI1PR0801MB2029;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2029;
X-Forefront-PRVS: 0784C803FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(346002)(366004)(39840400004)(376002)(396003)(199004)(189003)(956004)(446003)(11346002)(14444005)(3846002)(6116002)(8936002)(64126003)(65826007)(81166006)(81156014)(52116002)(23676004)(2486003)(76176011)(5660300001)(50466002)(8676002)(52146003)(6246003)(39060400002)(386003)(97736004)(2616005)(53546011)(478600001)(7736002)(7416002)(25786009)(106356001)(2906002)(66066001)(305945005)(105586002)(36756003)(575784001)(47776003)(65806001)(6666003)(4326008)(16526019)(26005)(77096007)(186003)(31686004)(65956001)(53936002)(16576012)(316002)(86362001)(476003)(486006)(58126008)(31696002)(6486002)(68736007)(230700001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2029;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMjk7MjM6dG42MDFPcE53ZUZBb0F1S0lLN0hPN2Zv?=
 =?utf-8?B?ZEkvZ3FLMlovZXRQL3VIRG93cGRLZ2ZRbHd0N3ZXTEdqcXJqcE1wVHF1S2R5?=
 =?utf-8?B?NzFsUDA5QkY5NmlZT2t3S1MzUW1PRnpEaE1kV1BWSWhuMVBZM1JpWTkyTFIx?=
 =?utf-8?B?UzdSbXR5Z21rcGpuazlGbUlqdDBrR1dtaG9GRG9DbGtYVTVzYnE2MWZEU1dn?=
 =?utf-8?B?eEdCekVLcm40bzQ5OWpzYzVWOTczc2s2UytIR3hPalNRbS9VbktGNG5kR3g3?=
 =?utf-8?B?N1JibWF1TUhFMHlDUmJKK1RzZkxTeEEwTTlpWVp1dVY3clBCSWtkaForeG95?=
 =?utf-8?B?UW0yRmlNNndicTQzV0RwNHloNENtcHN0cVhJMTZFR1d2MnIyMUpDWC90aXRa?=
 =?utf-8?B?Q1B0RU1QdGdxeW5JL1A5VUU5NlNBcmVsZU5kSlFYNFN5aWh5VjBseE1ZM29H?=
 =?utf-8?B?Z1lpVEdRU0trY2REVzB4eWFlMXlTVjZiRkpHeWVrbWQzOGNSQ2lydFIvMmVr?=
 =?utf-8?B?VXBZb3VMcDBIVG1kZUVRSUJoT0Y0NkkvSldLVDVUME5uVFhmMjk2Y1RBd3RB?=
 =?utf-8?B?eTFhM2puelZzR2hqNk9IZk9wT2drQkpueVBTT1FQem9oYk5ha3F3bEl0MDk4?=
 =?utf-8?B?QWI1NTNFZGtXSVpvbmZOSG5wZ0VITTZzMmVCc1Y1U0JZVlhwenU3VnpwK05D?=
 =?utf-8?B?SjFmTXgvaFlWc3pKVzFzazhSbkVPK2Rhd2NmaWhaTkVpemhBVUZmSWd2WXNC?=
 =?utf-8?B?R1JxdFQwRjJLTkZPeU04WUlIcmQyYzkrdkxMOFNod08xOXJpbFltSlpkeWRw?=
 =?utf-8?B?VHllV28rbmZrTGwyaXJuWEhwQ21EbC9ta1B1T3VwcElZQUk1ajFVUFRIT0Q3?=
 =?utf-8?B?U2JrbkV0S0xMWGFJSUlNSnRhUElzL3ZOZjFrSUZCK1VIcG9jNXduSU5qL3Av?=
 =?utf-8?B?eDMyMUlGUSs5SjVheUJPdTNJYy9oNlFsMW8ycnlKUnR2QW9HT1RRNlZQSWhE?=
 =?utf-8?B?Z3VORWs2b3dxeno0azkwcHREWFFyam5LWU9vNkNqYkgwd1VBYi9COEhwSVhN?=
 =?utf-8?B?eXMyVnNzUEVxai9POHdZbm50T2d4Sy9QR0lzdm1vc1g4WUJYOEJrZDArbUEw?=
 =?utf-8?B?eWNRQThlbUVqbjNsR2pvNHEwdFM4bmIyWTVHcVRTZUhNRjNxWGpxL0R1d1FZ?=
 =?utf-8?B?UmUwOFcrT1Z0WmhNSlowbENsY1YrcmRBbmhYRUp3ZEpLVWtwMjZRL01ucTJh?=
 =?utf-8?B?RkY0VUd0dFZkZ1c3NFQ2RGhzMFNZcE5Jc0p4SFRmWE1UM3kxTzc1bVpzTDRi?=
 =?utf-8?B?MGpBS053WCtQdjBGQlhZOVljbDduRG5xN0Nqc1RtRU55S1VuZVZQdGY3M0NV?=
 =?utf-8?B?dS9JVEpXVkR6K1U3MTg3Vnp4THNuUW9vWjZNdDZvMEhyT05tQ3UyOFVERDc0?=
 =?utf-8?B?UmVva3NJeHNJTXhjR3ZuTHFRYkZZRjNTQ2RveXZnNk5WdzRBcnMzd1VZKzc3?=
 =?utf-8?B?bjlTcW40NXRNOTdCM3NyWjhobW1xTWtCZ3BKOW5qTHBRWllZZGdnVmhOR0lW?=
 =?utf-8?B?K2QyK1ZSV0Jab1NyWGI5UlUrNjhqNG82OThRdllucjdrbklwVE9vOVI5ZWRt?=
 =?utf-8?B?NjROanpGdWl1THhJMCt2elZ2a2pZSEQwMTFyM0Y2Mi9VeDk5QnpNZElIc2FI?=
 =?utf-8?B?NkFHeURJZFltUnZWVE1UY3FEVCs4U25MY3kvVUhzSDhnRDg3SjQ5VDV1M2cx?=
 =?utf-8?B?NXNUbDFUMmViTE1tTEFuNndjRUZ0UkFCNE1OdjNPTkk0ZzFmbFdUOHhpNTk4?=
 =?utf-8?B?ZWFESlhUdXZ5dm0wR2Joa3o1M3hib2tNZE55MXpudWVtc01sL2IrYnMvZHpo?=
 =?utf-8?B?Yk8zcW4vc3dzN1k1RFpMamFUK2p1cW5tN1FvVTUzNmlTY1IrWWYzZjdkdTlV?=
 =?utf-8?B?enVUUyttQ3FNTks4TWIrMERQQ0NIUkwrMlNhQmUzL2FlMnJwQktrMk5ZV2lF?=
 =?utf-8?Q?fd+TQ1VR?=
X-Microsoft-Antispam-Message-Info: agYENPa+LZiUYDgD5DhtKp60BxgcOzxqlCh3eJ+COwrqsLwcwcGrSQNxpznEn89YG89WJasVXqnJzbSSdI7HQn5gv3gum7C2ptNIPaapIwceFClq+Y5OGFk2iyfqFL3x+x1FEtHpfmkfl3RM40u+/c00+AjPKFc2spzvWwEbiLMUi9XUdRYqUA3W4CK6fH7eV/tU/1w392H2LyJ6rO0tn/RC6g/J6VCDo1D4jd+HeH1XuWcRa7T7vGeslt9kh2AgIjdhSi54kGEzZkIEA8M8Rz8k0Cz8QmafXxapSX5pNp6kosfmbB/idx0rwmaxSOp4A4CgYvb1fzgfeGEatTnYyll9Hx3nD3/Mxkg4jSIOaGU=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;6:ns4k6saJRNik4xrWowNpJS+xFtQzLkfn0YvobftWAiSeKPZEPlofTb8v2iCdvNlkBRmNn4AmTrgVIIKYL1f8wxe2NUoe6CRLnZ8+4hVhC3G3OzrgTmYckcWoEkdyGW2cZZBjm7bOCOFwMAKm6LrxA/LqFn96B5rDFm1zgjHbzNNohySSxHzMrQ/Z7W1cXCBB6klitJC2IBKxtVkSszgnLRI5O31nnEoVTbY0+ijZIStpxvzs3xT8jCRmhJGGDepf8kjUpeDqGZwaiXXdqDOtLQp1yMdUo8xdd1jVZFGfxziNEykNiWXzNWr5hkmJkTUuwMlCR6VdejEeROl8uzyh7019uwXnDFyjkcEe2/WiAo7wgyY5SbqWkh6+uWwa/rPCDqdZvyt9AX67TcIg5uojFyA0F2zcGENwbL3wBcRtAbcexv7Gnk4Be/xhMGC40eDZOlDuY+qPlkDmRRyF/5MZLw==;5:BRIbx0VIgF9t/2rdtzbk92bP4CV5oikgZJfy3J+658AButp1pzTZ9+4za7uVDAJO28LN+drpaol48696DvKTgomkjeAPayPjFe82osRd93DFGuvqCfTkVhWJfrpsWffGorbcOHaVkfGUvtsY+vhA+nIu4SUPgV7j9BEJKPFHrhw=;7:YwMvPbqFCs/o/IyBBICxu/P8i0Z35DQWSISGEYcdsyE2jG61YTZCEZhVcKQlDgUvr7vKyc9xFWOkz5vPKx+kgmawanyr6hFaRTYfySSxCKjnsPgxN4C+U08AUKl5vdrLd1+Y27X2ZQPVmzE2p2KmJGQfFyLZWd+Iqz4qL5vznuxzGnrBmg+acXHtMMs56fSY9PC2BZwsbafT4kDbsAKT9Dbb/qNiFI8nnAOdwoorX1Ck0MPqJypAz4glLk5glmyu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;20:qNYz1kymZ8Edin3y0SUTofhn/vdB6mZ158hlqjoYJIa85qf+uHmmYfa61kuVLQgZv8JeSp5PfSOA0NwzwR10Xc49Be1ZQDkpXMWpsl7VNcbp4+fHNu0UpQOjksRyFFdnT7/LiBxY+B32roEfR+HWtJP9rgAZ2xVXzO+keWWL/rY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2018 14:56:59.9352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8326d79c-bc45-47d0-c451-08d611ad8131
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.09.2018 07:37, Christian Brauner wrote:
> - Backwards Compatibility:
>   If userspace wants to determine whether ipv6 RTM_GETADDR requests support
>   the new IFA_IF_NETNSID property they should verify that the reply after
>   sending a request includes the IFA_IF_NETNSID property. If it does not
>   userspace should assume that IFA_IF_NETNSID is not supported for ipv6
>   RTM_GETADDR requests on this kernel.
> - From what I gather from current userspace tools that make use of
>   RTM_GETADDR requests some of them pass down struct ifinfomsg when they
>   should actually pass down struct ifaddrmsg. To not break existing
>   tools that pass down the wrong struct we will do the same as for
>   RTM_GETLINK | NLM_F_DUMP requests and not error out when the
>   nlmsg_parse() fails.
> 
> - Security:
>   Callers must have CAP_NET_ADMIN in the owning user namespace of the
>   target network namespace.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> v0->v1:
> - unchanged
> ---
>  net/ipv6/addrconf.c | 70 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 55 insertions(+), 15 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index d51a8c0b3372..00f1af374150 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -4491,6 +4491,7 @@ static const struct nla_policy ifa_ipv6_policy[IFA_MAX+1] = {
>  	[IFA_CACHEINFO]		= { .len = sizeof(struct ifa_cacheinfo) },
>  	[IFA_FLAGS]		= { .len = sizeof(u32) },
>  	[IFA_RT_PRIORITY]	= { .len = sizeof(u32) },
> +	[IFA_IF_NETNSID]	= { .type = NLA_S32 },
>  };
>  
>  static int
> @@ -4794,7 +4795,8 @@ static inline int inet6_ifaddr_msgsize(void)
>  }
>  
>  static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
> -			     u32 portid, u32 seq, int event, unsigned int flags)
> +			     u32 portid, u32 seq, int event, unsigned int flags,
> +			     int netnsid)
>  {
>  	struct nlmsghdr  *nlh;
>  	u32 preferred, valid;
> @@ -4806,6 +4808,9 @@ static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
>  	put_ifaddrmsg(nlh, ifa->prefix_len, ifa->flags, rt_scope(ifa->scope),
>  		      ifa->idev->dev->ifindex);
>  
> +	if (netnsid >= 0 && nla_put_s32(skb, IFA_IF_NETNSID, netnsid))
> +		goto error;
> +
>  	if (!((ifa->flags&IFA_F_PERMANENT) &&
>  	      (ifa->prefered_lft == INFINITY_LIFE_TIME))) {
>  		preferred = ifa->prefered_lft;
> @@ -4855,7 +4860,8 @@ static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
>  }
>  
>  static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
> -				u32 portid, u32 seq, int event, u16 flags)
> +			       u32 portid, u32 seq, int event, u16 flags,
> +			       int netnsid)
>  {
>  	struct nlmsghdr  *nlh;
>  	u8 scope = RT_SCOPE_UNIVERSE;
> @@ -4868,6 +4874,9 @@ static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
>  	if (!nlh)
>  		return -EMSGSIZE;
>  
> +	if (netnsid >= 0 && nla_put_s32(skb, IFA_IF_NETNSID, netnsid))
> +		return -EMSGSIZE;
> +
>  	put_ifaddrmsg(nlh, 128, IFA_F_PERMANENT, scope, ifindex);
>  	if (nla_put_in6_addr(skb, IFA_MULTICAST, &ifmca->mca_addr) < 0 ||
>  	    put_cacheinfo(skb, ifmca->mca_cstamp, ifmca->mca_tstamp,
> @@ -4881,7 +4890,8 @@ static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
>  }
>  
>  static int inet6_fill_ifacaddr(struct sk_buff *skb, struct ifacaddr6 *ifaca,
> -				u32 portid, u32 seq, int event, unsigned int flags)
> +			       u32 portid, u32 seq, int event,
> +			       unsigned int flags, int netnsid)

Here we will have 7 arguments, while we have only 6 x86 registers. Can we do something
with this?

>  {
>  	struct net_device *dev = fib6_info_nh_dev(ifaca->aca_rt);
>  	int ifindex = dev ? dev->ifindex : 1;
> @@ -4895,6 +4905,9 @@ static int inet6_fill_ifacaddr(struct sk_buff *skb, struct ifacaddr6 *ifaca,
>  	if (!nlh)
>  		return -EMSGSIZE;
>  
> +	if (netnsid >= 0 && nla_put_s32(skb, IFA_IF_NETNSID, netnsid))
> +		return -EMSGSIZE;
> +
>  	put_ifaddrmsg(nlh, 128, IFA_F_PERMANENT, scope, ifindex);
>  	if (nla_put_in6_addr(skb, IFA_ANYCAST, &ifaca->aca_addr) < 0 ||
>  	    put_cacheinfo(skb, ifaca->aca_cstamp, ifaca->aca_tstamp,
> @@ -4916,7 +4929,7 @@ enum addr_type_t {
>  /* called with rcu_read_lock() */
>  static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
>  			  struct netlink_callback *cb, enum addr_type_t type,
> -			  int s_ip_idx, int *p_ip_idx)
> +			  int s_ip_idx, int *p_ip_idx, int netnsid)
>  {
>  	struct ifmcaddr6 *ifmca;
>  	struct ifacaddr6 *ifaca;
> @@ -4936,7 +4949,7 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
>  						NETLINK_CB(cb->skb).portid,
>  						cb->nlh->nlmsg_seq,
>  						RTM_NEWADDR,
> -						NLM_F_MULTI);
> +						NLM_F_MULTI, netnsid);
>  			if (err < 0)
>  				break;
>  			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
> @@ -4953,7 +4966,7 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
>  						  NETLINK_CB(cb->skb).portid,
>  						  cb->nlh->nlmsg_seq,
>  						  RTM_GETMULTICAST,
> -						  NLM_F_MULTI);
> +						  NLM_F_MULTI, netnsid);
>  			if (err < 0)
>  				break;
>  		}
> @@ -4968,7 +4981,7 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
>  						  NETLINK_CB(cb->skb).portid,
>  						  cb->nlh->nlmsg_seq,
>  						  RTM_GETANYCAST,
> -						  NLM_F_MULTI);
> +						  NLM_F_MULTI, netnsid);
>  			if (err < 0)
>  				break;
>  		}
> @@ -4985,6 +4998,9 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
>  			   enum addr_type_t type)
>  {
>  	struct net *net = sock_net(skb->sk);
> +	struct nlattr *tb[IFA_MAX+1];
> +	struct net *tgt_net = net;
> +	int netnsid = -1;

This function already has 10 local variables, while this patch adds 3 more.
Documentation/process/coding-style.rst says:

   Another measure of the function is the number of local variables.  They
   shouldn't exceed 5-10, or you're doing something wrong.  Re-think the
   function, and split it into smaller pieces.  A human brain can
   generally easily keep track of about 7 different things, anything more
   and it gets confused.

Can we do something with this?

>  	int h, s_h;
>  	int idx, ip_idx;
>  	int s_idx, s_ip_idx;
> @@ -4996,11 +5012,22 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
>  	s_idx = idx = cb->args[1];
>  	s_ip_idx = ip_idx = cb->args[2];
>  
> +	if (nlmsg_parse(cb->nlh, sizeof(struct ifaddrmsg), tb, IFA_MAX,
> +			ifa_ipv6_policy, NULL) >= 0) {
> +		if (tb[IFA_IF_NETNSID]) {
> +			netnsid = nla_get_s32(tb[IFA_IF_NETNSID]);
> +
> +			tgt_net = rtnl_get_net_ns_capable(skb->sk, netnsid);
> +			if (IS_ERR(tgt_net))
> +				return PTR_ERR(tgt_net);
> +		}
> +	}
> +
>  	rcu_read_lock();
> -	cb->seq = atomic_read(&net->ipv6.dev_addr_genid) ^ net->dev_base_seq;
> +	cb->seq = atomic_read(&tgt_net->ipv6.dev_addr_genid) ^ tgt_net->dev_base_seq;
>  	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
>  		idx = 0;
> -		head = &net->dev_index_head[h];
> +		head = &tgt_net->dev_index_head[h];
>  		hlist_for_each_entry_rcu(dev, head, index_hlist) {
>  			if (idx < s_idx)
>  				goto cont;
> @@ -5012,7 +5039,7 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
>  				goto cont;
>  
>  			if (in6_dump_addrs(idev, skb, cb, type,
> -					   s_ip_idx, &ip_idx) < 0)
> +					   s_ip_idx, &ip_idx, netnsid) < 0)
>  				goto done;
>  cont:
>  			idx++;
> @@ -5023,6 +5050,8 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
>  	cb->args[0] = h;
>  	cb->args[1] = idx;
>  	cb->args[2] = ip_idx;
> +	if (netnsid >= 0)
> +		put_net(tgt_net);
>  
>  	return skb->len;
>  }
> @@ -5053,12 +5082,14 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
>  			     struct netlink_ext_ack *extack)
>  {
>  	struct net *net = sock_net(in_skb->sk);
> +	struct net *tgt_net = net;
>  	struct ifaddrmsg *ifm;
>  	struct nlattr *tb[IFA_MAX+1];
>  	struct in6_addr *addr = NULL, *peer;
>  	struct net_device *dev = NULL;
>  	struct inet6_ifaddr *ifa;
>  	struct sk_buff *skb;
> +	int netnsid = -1;
>  	int err;
>  
>  	err = nlmsg_parse(nlh, sizeof(*ifm), tb, IFA_MAX, ifa_ipv6_policy,
> @@ -5066,15 +5097,24 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
>  	if (err < 0)
>  		return err;
>  
> +	if (tb[IFA_IF_NETNSID]) {
> +		netnsid = nla_get_s32(tb[IFA_IF_NETNSID]);
> +
> +		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(in_skb).sk,
> +						  netnsid);
> +		if (IS_ERR(tgt_net))
> +			return PTR_ERR(tgt_net);
> +	}
> +
>  	addr = extract_addr(tb[IFA_ADDRESS], tb[IFA_LOCAL], &peer);
>  	if (!addr)
>  		return -EINVAL;
>  
>  	ifm = nlmsg_data(nlh);
>  	if (ifm->ifa_index)
> -		dev = dev_get_by_index(net, ifm->ifa_index);
> +		dev = dev_get_by_index(tgt_net, ifm->ifa_index);
>  
> -	ifa = ipv6_get_ifaddr(net, addr, dev, 1);
> +	ifa = ipv6_get_ifaddr(tgt_net, addr, dev, 1);
>  	if (!ifa) {
>  		err = -EADDRNOTAVAIL;
>  		goto errout;
> @@ -5087,14 +5127,14 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
>  	}
>  
>  	err = inet6_fill_ifaddr(skb, ifa, NETLINK_CB(in_skb).portid,
> -				nlh->nlmsg_seq, RTM_NEWADDR, 0);
> +				nlh->nlmsg_seq, RTM_NEWADDR, 0, netnsid);
>  	if (err < 0) {
>  		/* -EMSGSIZE implies BUG in inet6_ifaddr_msgsize() */
>  		WARN_ON(err == -EMSGSIZE);
>  		kfree_skb(skb);
>  		goto errout_ifa;
>  	}
> -	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
> +	err = rtnl_unicast(skb, tgt_net, NETLINK_CB(in_skb).portid);
>  errout_ifa:
>  	in6_ifa_put(ifa);
>  errout:
> @@ -5113,7 +5153,7 @@ static void inet6_ifa_notify(int event, struct inet6_ifaddr *ifa)
>  	if (!skb)
>  		goto errout;
>  
> -	err = inet6_fill_ifaddr(skb, ifa, 0, 0, event, 0);
> +	err = inet6_fill_ifaddr(skb, ifa, 0, 0, event, 0, -1);
>  	if (err < 0) {
>  		/* -EMSGSIZE implies BUG in inet6_ifaddr_msgsize() */
>  		WARN_ON(err == -EMSGSIZE);

Thanks,
Kirill
