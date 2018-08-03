Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391E5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49782174B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J87Seqv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49782174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbeHCK5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:57:55 -0400
Received: from mail-eopbgr50098.outbound.protection.outlook.com ([40.107.5.98]:54112
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728442AbeHCK5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiMLjU4Rd1G3iAB2cOltslKaYXm01xqo6XwMfMzLQ8I=;
 b=J87Seqv36Aym9+f7k/emtmrEIxiyFElnu5s3gSYIGNPMYOCWWsFOH9Y33IpVpFFTHYYfQ2kpNRxOYIE9SY6YD7S5EsCmP6t7HlqCXraN5/YT/sKBfAFYjv0bWkm7EsZzmvU97AP9VCQiTGNGEGyJiWog5awlTi8fa58RzmjgDOg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 VI1PR0801MB2030.eurprd08.prod.outlook.com (2603:10a6:800:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 09:02:28 +0000
Subject: Re: [PATCH] mm: Move check for SHRINKER_NUMA_AWARE to
 do_shrink_slab()
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     vdavydov.dev@gmail.com, mhocko@suse.com, aryabinin@virtuozzo.com,
        ying.huang@intel.com, penguin-kernel@I-love.SAKURA.ne.jp,
        willy@infradead.org, shakeelb@google.com, jbacik@fb.com,
        linux-mm@kvack.org
References: <153320759911.18959.8842396230157677671.stgit@localhost.localdomain>
 <20180802134723.ecdd540c7c9338f98ee1a2c6@linux-foundation.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <47c34fad-5d11-53b0-4386-61be890163c5@virtuozzo.com>
Date:   Fri, 3 Aug 2018 12:02:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802134723.ecdd540c7c9338f98ee1a2c6@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR05CA0031.eurprd05.prod.outlook.com (2603:10a6:205::44)
 To VI1PR0801MB2030.eurprd08.prod.outlook.com (2603:10a6:800:8b::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8f971de-21c0-49c9-e182-08d5f91fd779
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2030;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;3:TlrVI+zC+hpWeJ7vJLLqKqYuaUTJOtNRoJd9OBuqE/chYSpAJYzQzpSBiLYAWP2oXa3ao62o/gnzEJTA4+VotuJlL4DgoLqrjZrM+W0ryDStrngTaTzD+CxzPMsz4vTST15axnnU/fbltpwJ/jHN9vUZfF5oRmdoYCR6/k76Jn+z7zJL1JWOScewyTxenAOkn4I9Y/QxEkw07HqyzlZOZjkOJbWNrFJCIF6pB/FBS3FHpg4PjGLeAS78RwsGYD3O;25:PlRbP4J0g46Zaw4kR5c0So0FNxjQzAb8uUj07xVTXijkz4O6pa+HjXY6ApEjCbngFMhIKMAeeUE56CpEahCyVWGRuZJYgFHVwBDclAzQQFfbeBC08acYJUqOuDbMf5ElIeo19DE9KngPz7A2EMZI5DR0X6LJsPAXOp+2nyCVz2o3VCLX+IbgIExrzBWQtw2JSZdqofbT9bC7/lJiWZ9kiNZhKm0vOoZ0brrOVmHZkdKxvuyTkIjbYejxBczKvEV0+qVwgghBKbwo/WkdhkDNiAuo6jiDbhcstSHtC1UxeBXm0LzZ58FX1XIvFd91zynuQyWIfg1YKi6Fg8SgZ+4fOA==;31:cuY46I8ISkke0F0AMi7Y6beomPTGdLFWuFRnB/8B6/PCMd0FftBAFy2DLl4UQchBHxcwP4G6tfJGkKyxKl4ZfgZFmh65mCjuON3zjD3rMkLInWnzNQyOn7BamDBefrBkRizLumHCjuaqzdaXYW9EuYwd0vIQ3PMi4GzhVBRmzVYtLSBuWgNmbx2u5ieqn6x/nQd+aitN6liKnNKPJntK3Thn07UajTZz1lswH9T7hBw=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2030:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;20:vEadvTkk4P/uLk8LaSy/bhV1qPb2wFOhnvt4xI+VIlcx1eSaztWhAFVAqiOdOTbTC2Sj7tD2/mc9WiR2iizXsQU/O4oJpD7loK6oTob1vxDOsAZJXLQ+yz5vvADXCknZiOejNlpn9Lxcd7dXKAB8BGrlONuOvVgoCCsPcO7r6hjyRrY+nfe4FXpwdYveVRICFTxZZW+fAUeK24w3gt1IHQvqwtl5Fzp4WJ2UQpIebMcM07TLntp9MmL0IvRNDVRO3o2hI37uOU/baX1ZIRexWLEdVangglxlE5yySW+qt6LxdR0IZlTEMFIrwG/oFy3whXViQ2rfirBgh/No7Dc87xcEQ6i4roTFMFOdbmAu6k34qCdbFnj0+79Qv/6pUU8utFjaIIj+GN1aB12PXHTozNPBHmNISw9wwHvnwBqkOQZWTfGu3vBw8sazhOlMJlRodkWyZlqyHuIKy44PxuKIxArCie1YJZmiqnOYbGTZ6vuK2z7qjo2MqrdOS/UdX1fO;4:C/maLIW4FV9nsvtTGqGkIn+zEOB2FYMiS7j8/sIymWW/2pOHcPmzI4NzMWfMbtXglVsXhlPtmXcE7EitLl5PcfVA6cn/MtYcEeFVf2NgH6MJbKLRparzJa9MW+CTaZoBd8EN7xMK/bv9QwGKq7/JqDrHajn6fRsxFhnsly7L6QSuU8KtoayXAPdyiA80QAiVQR/VrlMga5M0wNOFZIBC9hvBELGpuhFe+PUk8R3nKgTuTXNmPWsbFWin4IXsTd3yvt7dxX8ZbclFKvjS7hlZfQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2030F569415A76D9DFC9A9A8CD230@VI1PR0801MB2030.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2030;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2030;
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(376002)(39850400004)(366004)(136003)(189003)(199004)(186003)(16526019)(53546011)(76176011)(81156014)(26005)(386003)(65956001)(65806001)(66066001)(47776003)(77096007)(8936002)(81166006)(8676002)(5660300001)(305945005)(65826007)(6116002)(64126003)(50466002)(230700001)(7736002)(3846002)(6486002)(6306002)(229853002)(2486003)(52146003)(23676004)(52116002)(36756003)(97736004)(105586002)(478600001)(31696002)(86362001)(6246003)(316002)(31686004)(53936002)(110136005)(966005)(2616005)(486006)(106356001)(4326008)(476003)(25786009)(58126008)(7416002)(11346002)(16576012)(956004)(446003)(68736007)(39060400002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2030;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMzA7MjM6NUMzSXdlS2FhSFdYNnExRDE2Wm12eGpt?=
 =?utf-8?B?VHkxd0M2WmxSWXNDNWNFTkNnVTdjTmhjNDhHVnk2T1ByR2pieEE0K0FCbjZz?=
 =?utf-8?B?MEIvKzBIUHdtV0g1OWgxSmwxQ1VQZ0JsZE1QdzVOaGtMd2pmbWMzblJYQUlG?=
 =?utf-8?B?UlNiV1BOZWhuQTZnK092aW0xUXlDUERRL1ZtODBJRDdvd2R4QUs5U0NVcCtn?=
 =?utf-8?B?TDdVb3dGUS9ZbTN4S2VDdGZZRm1sb3Q1bDYycW9IT1FHb1IwdG0rN2tVd00x?=
 =?utf-8?B?dk5iL3p3UThhdXNTUVk5ZVJSaUNVMnpSem5CV1ZiZ0ZHbnBQbGFIR3U1cXFj?=
 =?utf-8?B?TU5mWFI4SEJmY1VtNUtGTHZvK2toeFNHeWlZQ2xLc3BPM0wrS2lYV1dxa2xx?=
 =?utf-8?B?aDBTSnJTMklaWFpmQ3dCQ2lQcG5wVXBIc2R0Z1RRVlpSR1B6QlFqMlRPdXZn?=
 =?utf-8?B?ajZNazVtN1JHNDhLTkxVWnl5QTdEUjVHa0VXbjhIZld0bzdsai9neXlQOTB4?=
 =?utf-8?B?cm5Ncnl1TTFxSk12WHNFcnRLMnd3Z3ljZFFlSHNLdlZDa1FkcHpsT2lmeUJO?=
 =?utf-8?B?MHdLZWlCdE0yaEFBNVdIQ2FCMitnS3pWekdJcWtuRlg3U3AxNVpxdXNLTU9s?=
 =?utf-8?B?VGRQUGxqWkNZejRyS1NHaE5nSno3NVVTQ3dtaGV4TXZQejFaczRCUzZ3OXJ6?=
 =?utf-8?B?RXYxd3ZVQjhzQW84RnZoMXNuU0dNTG9KTWg1VlZ2R2NVdUYxMVNxdGhYYmlB?=
 =?utf-8?B?SFlmSHFLYzRpYzM5dVF2ckRiZ2crRnJBSDRSYU1QYWFCbFQyZTgvTjVNZnlC?=
 =?utf-8?B?Sy8wZE84UlRnYThueDlkVkVjODl6T3BaUWVSaGU3TEFKSGtNN00zZjI2dEp5?=
 =?utf-8?B?OWFJQUJzaHp6UUZ5bWNNN0h3YkgvOFFMZnQrRkxRRjhzRFdyQTQ5Y2p1VkN2?=
 =?utf-8?B?VDVQTjFEVFpsQkxSUElnc2FQdDR5Q2FvTWYraUdNTHo0Q1BZVGRZR2NFdk85?=
 =?utf-8?B?NCt6QVNRWS9sbHJLd1hYOE9MMWx5R0s5QnlMK3V2RVMvaTQ5OTNmQXBsQTU0?=
 =?utf-8?B?c3F4Z3BwdDQvRFliUjBYcmFlV21Ld05iZ1h3aHVDTHN5dFVaQm91eEtVMzV3?=
 =?utf-8?B?b2hQRVlLWk4zZlQwZDRleEhnSXNtSXRnK0lNZEdMdFpPeUI5Q2FmNWZmNnpK?=
 =?utf-8?B?Q3dvdzlyRmgzdUcwcmhqbjMybDR0UEpsM2ZSTzB2bFlOSkR4cHBvbG5TdzBF?=
 =?utf-8?B?VW5sYnA3NUFKTlc1Q2VLbk9rN3ZnUjNOVHhjZ2tlTGxJVVZTdWJ4TlluUUly?=
 =?utf-8?B?REQ5N3lvdlV2cHl4QVR2eVVqRnBTaHdGQUZFVVBlWWI0dUVRSTF2dTQvTm9D?=
 =?utf-8?B?ZmFGM3J4cTFzTFE1U1RIa3VUalROR1pzMk8wbWhNVE9FaWRWVE01ZThkaXNH?=
 =?utf-8?B?MzlMN0hRWlBzREVGMjAyQ2liMURCTzVRYU5ja1cyWitLS1VHYmswS0hUayto?=
 =?utf-8?B?cm5OUksxcFAydHkyd051NVplcUgyN2dBQ0hsdUNjcGNDUDgxRUx0NWVDaXVT?=
 =?utf-8?B?bkRzYkxJaXB5OEE1cGQ5dE1kcThhT3pzajRXOE0ySk10VVJQQU50MmlLQmdi?=
 =?utf-8?B?WG9wNjRWamVEeFk0TEczMFBsQVJ2U1ovWlYvWS9iWjE1UmxTcXZuNDlxYnhv?=
 =?utf-8?B?QTVBNzRLZ3hxS0FJSXgzbnRFQUJPVVpxb3RsR3R6NGtwWjBGcERSN29EZlJ0?=
 =?utf-8?B?RUEwaWhGNEFEaG9FWUFYWWNuUS8wRGxJVWR0dCtuckltSERZRGdhQ3J6MFRp?=
 =?utf-8?B?UHFJcU9BNDdONm1KdCsvbUNnSGkwb1c5VjhFZVhWU0FkM2VHRWhXU0NVMm15?=
 =?utf-8?B?TThIZ1pjUVNic0xES3hyMHlrelhkakx6SWVRT2hIVkJrQjlodk1IOHNwSGJu?=
 =?utf-8?B?d2k2U0UveFRuNDR4dGdKM2tOUUlVUW1PeENCUndVbkMwUHJzcDBWN1dBMjVC?=
 =?utf-8?Q?fmHYfjPP?=
X-Microsoft-Antispam-Message-Info: 2KkRDhr6EPyec8Z8NGGgzxyKyFRIHK88nn8CT/fNZFG/+tgAFgup8tSgHyWm4dbst5bRuqaZA4MzFA8xCSKUR3KHKJLXYnYXxuIqC2AEZcSTn01gw87FGHP62syBBQReMVENK2xilbDfTpkgyVZX7YOi/j3MA87s9ZwxxZ5AbiJsm7J7BwS/pgymbJkzrJL8AV0hE9g0u9RiSe3nhWX+iFylnDJSa/J0BytejH28e/DUnYUwXa1WD0DcbO1vHL4sGNTdqGChZYSntsTbu0e3L/9rL4pqDj8mQcSi51L4O7RQteUdPtfzh9WCtz0+JbVbwudMiSXZNazPMshBJLEZwk+1QqO2w60UV9mUbJFp+MU=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;6:0ap1zaPUUqHu4Zuc5DsK6SGY1I4sAXMdDlT4w5R548JFOTWCb9BVbp/zaS7QdVpce29oVrNmHeNe9frcDw5pIL6S01T043u0hsl6SCXD6L71wq4zFQM6+IoyWprkxtfkQNmxxBihfqn2dxhp4oCwOeOcQwsciGV4L9HdEfaU3fKLl2NfexONh28FgocY7HX9Z23ZodtN21yxvKr5S1rf2WLo/KSqj+9V9dEPTNYZpiS+0OeiDMDPXlyJr1NCr2ki1o1p586cVonPR3Qphl/cFn7Fzbvp5qdrrfF2nvkzPK74FQ/giyFG3awkz8FI8wSpEW0UB7iOA5c6pvh1Q9ovIK/5865qwSE5mZ26e9hYKSI3ExHOMdxqENxQws3DRyJm+lHzeNI4L2vvjN7bznibuP6FXN98RplbMXADXoUDnn/vlRv9QMuntSzgbBIE+3BitEgRwLrlr4fauEbd/fM7Jw==;5:ewCAwgiHnkFO/tCYMEMrZxt3FGx9gJGLQcN/+d0ntK2FFxeCPZKfzKphGfBPqDPgqqRpUC4fxsPefVxfSPxgJTpbrfcGCYchayJExwBEeYmEOz8xKbHR2JhLDrzrdD2SQDmca2TVEEfsKUF5i+p+LiwKSGpnwU0saC4tvzzkyN4=;7:l7J9CnUHaEsPKqocQxcmK0y85lgVXm1j8DBn/Wkokpki4i8LluorqO5V0sDCcABJGVvId8x6B2DruUm2VQ7dyH7bUJhLfm/xEBH9U2i+IiN03tqNXdJGkruj7Rcd1OLT6x2EEX2wXHNmigEllqh4mOUSwzIcPdJpbuRQpKZm6YvNcClRbZRiISsRkFWWVJsSPwoJHQPLT2caS+iWtwXydn4I8wX4ixaFdGHcC0B7aJAMObMUWOTc26qLAC8f3b/O
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;20:07rJQkmdmnZWvfR+qZwc4mrSoOB2ST4rhu0WWJX6SK+ihtSFUv/VtUOaiVhxRDV4CBIr7NTbKvWIseTrPWKAJ4qYfwOXmx2eiYbq28MR8yT+GxdC9UqpA6cWKzdcZ+BoPLxxo70waji2PD3URX2hXtnT3oNUIQQkEE0XACSWh0E=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 09:02:28.6735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f971de-21c0-49c9-e182-08d5f91fd779
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.2018 23:47, Andrew Morton wrote:
> On Thu, 02 Aug 2018 14:00:52 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
>> In case of shrink_slab_memcg() we do not zero nid, when shrinker
>> is not numa-aware. This is not a real problem, since currently
>> all memcg-aware shrinkers are numa-aware too (we have two:
>> super_block shrinker and workingset shrinker), but something may
>> change in the future.
> 
> Fair enough.
> 
>> (Andrew, this may be merged to mm-iterate-only-over-charged-shrinkers-during-memcg-shrink_slab)
> 
> It got a bit messy so I got lazy and queued it as a separate patch.
> 
> btw, I have a note that https://lkml.org/lkml/2018/7/7/32 was caused by
> this patch series.  Is that the case and do you know if this was
> addressed?

It's not related to the patchset. Bisect leads to:

commit c6aeb9d4c351 (HEAD, refs/bisect/bad)
Author: David Howells <dhowells@redhat.com>
Date:   Sun Jun 24 00:20:10 2018 +0100

kernfs, sysfs, cgroup, intel_rdt: Support fs_context

CC David.

David, please see reproducer at https://lkml.org/lkml/2018/7/7/32

Kirill
