Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE4FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752AA20652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="WtTt4U/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbfAKSJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:09:10 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:51294 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727745AbfAKSJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:09:09 -0500
X-Greylist: delayed 1581 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2019 13:09:08 EST
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id x0BHauSV001215;
        Fri, 11 Jan 2019 17:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=OyoTsixlIhHy1nh7+lzIG0GYyTqdB5ch6hhzbbmEPQU=;
 b=WtTt4U/k6YKKTUi3zWaf3RdL6UP6LParvvu3f3Dp2ImIb+sJjazgpYAW5BJBwqXR9dM3
 NMp+WaJdJofrYbNVEYpn/M3ptYWEsHwouFZIZXarXyqdR6EVPsLcFlwzNr9KGYloky3O
 NmcSPNj8teRKKi+fNVSQ9LKhqO0WwGCZZQ//YFCIBPgLI4ENc5PUSYFcQbxbr041vXPO
 sHqdAuRTtJozoRIVOfaPHhEvPq3JOijQI3dEpyEyoTgs8aGvZCOaBgHG3A7GzmouA65k
 X9SMjlow49PXHLDtQlJ4gljyAC2dQQUHW1aGKzw9MFCOjrPMaeHQRktisBPPgFjcH/sZ bg== 
Received: from prod-mail-ppoint3 (a96-6-114-86.deploy.static.akamaitechnologies.com [96.6.114.86] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 2px8v3vnkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jan 2019 17:41:19 +0000
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x0BHVn0K011081;
        Fri, 11 Jan 2019 12:41:17 -0500
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2px20v6bda-1;
        Fri, 11 Jan 2019 12:41:17 -0500
Received: from [172.28.12.125] (bos-lpjec.kendall.corp.akamai.com [172.28.12.125])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 71DB01FC79;
        Fri, 11 Jan 2019 17:41:16 +0000 (GMT)
Subject: Re: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nadav Amit <namit@vmware.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
 <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
 <20190110172004.wuh45xoafynfm2df@treble>
 <20190110123243.3b9e0856@gandalf.local.home>
 <20190110174257.GE16556@linux.intel.com>
 <20190110125757.1c8d2870@gandalf.local.home>
 <20190110180428.GG16556@linux.intel.com>
 <e5ea3781-336d-7b03-a22e-5012e915affd@oracle.com>
 <20190111152809.ejutcmqrx4ud3fli@treble>
 <ad6fae93-4122-7854-aa4c-2facd67ca839@oracle.com>
 <20190111165752.z6e2dfktj2caqi4n@treble>
From:   Jason Baron <jbaron@akamai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jbaron@akamai.com; prefer-encrypt=mutual; keydata=
 xsFNBFnyIJMBEADamFSO/WCelO/HZTSNbJ1YU9uoEUwmypV2TvyrTrXULcAlH1sXVHS3pNdR
 I/koZ1V7Ruew5HJC4K9Z5Fuw/RHYWcnQz2X+dSL6rX3BwRZEngjA4r/GDi0EqIdQeQQWCAgT
 VLWnIenNgmEDCoFQjFny5NMNL+i8SA6hPPRdNjxDowDhbFnkuVUBp1DBqPjHpXMzf3UYsZZx
 rxNY5YKFNLCpQb1cZNsR2KXZYDKUVALN3jvjPYReWkqRptOSQnvfErikwXRgCTasWtowZ4cu
 hJFSM5Asr/WN9Wy6oPYObI4yw+KiiWxiAQrfiQVe7fwznStaYxZ2gZmlSPG/Y2/PyoCWYbNZ
 mJ/7TyED5MTt22R7dqcmrvko0LIpctZqHBrWnLTBtFXZPSne49qGbjzzHywZ0OqZy9nqdUFA
 ZH+DALipwVFnErjEjFFRiwCWdBNpIgRrHd2bomlyB5ZPiavoHprgsV5ZJNal6fYvvgCik77u
 6QgE4MWfhf3i9A8Dtyf8EKQ62AXQt4DQ0BRwhcOW5qEXIcKj33YplyHX2rdOrD8J07graX2Q
 2VsRedNiRnOgcTx5Zl3KARHSHEozpHqh7SsthoP2yVo4A3G2DYOwirLcYSCwcrHe9pUEDhWF
 bxdyyESSm/ysAVjvENsdcreWJqafZTlfdOCE+S5fvC7BGgZu7QARAQABzR9KYXNvbiBCYXJv
 biA8amJhcm9uQGFrYW1haS5jb20+wsF+BBMBAgAoBQJZ8iCTAhsDBQkJZgGABgsJCAcDAgYV
 CAIJCgsEFgIDAQIeAQIXgAAKCRC4s7mct4u0M9E0EADBxyL30W9HnVs3x7umqUbl+uBqbBIS
 GIvRdMDIJXX+EEA6c82ElV2cCOS7dvE3ssG1jRR7g3omW7qEeLdy/iQiJ/qGNdcf0JWHYpmS
 ThZP3etrl5n7FwLm+51GPqD0046HUdoVshRs10qERDo+qnvMtTdXsfk8uoQ5lyTSvgX4s1H1
 ppN1BfkG10epsAtjOJJlBoV9e92vnVRIUTnDeTVXfK11+hT5hjBxxs7uS46wVbwPuPjMlbSa
 ifLnt7Jz590rtzkeGrUoM5SKRL4DVZYNoAVFp/ik1fe53Wr5GJZEgDC3SNGS/u+IEzEGCytj
 gejvv6KDs3KcTVSp9oJ4EIZRmX6amG3dksXa4W2GEQJfPfV5+/FR8IOg42pz9RpcET32AL1n
 GxWzY4FokZB0G6eJ4h53DNx39/zaGX1i0cH+EkyZpfgvFlBWkS58JRFrgY25qhPZiySRLe0R
 TkUcQdqdK77XDJN5zmUP5xJgF488dGKy58DcTmLoaBTwuCnX2OF+xFS4bCHJy93CluyudOKs
 e4CUCWaZ2SsrMRuAepypdnuYf3DjP4DpEwBeLznqih4hMv5/4E/jMy1ZMdT+Q8Qz/9pjEuVF
 Yz2AXF83Fqi45ILNlwRjCjdmG9oJRJ+Yusn3A8EbCtsi2g443dKBzhFcmdA28m6MN9RPNAVS
 ucz3Oc7BTQRZ8iCTARAA2uvxdOFjeuOIpayvoMDFJ0v94y4xYdYGdtiaqnrv01eOac8msBKy
 4WRNQ2vZeoilcrPxLf2eRAfsA4dx8Q8kOPvVqDc8UX6ttlHcnwxkH2X4XpJJliA6jx29kBOc
 oQOeL9R8c3CWL36dYbosZZwHwY5Jjs7R6TJHx1FlF9mOGIPxIx3B5SuJLsm+/WPZW1td7hS0
 Alt4Yp8XWW8a/X765g3OikdmvnJryTo1s7bojmwBCtu1TvT0NrX5AJId4fELlCTFSjr+J3Up
 MnmkTSyovPkj8KcvBU1JWVvMnkieqrhHOmf2qdNMm61LGNG8VZQBVDMRg2szB79p54DyD+qb
 gTi8yb0MFqNvXGRnU/TZmLlxblHA4YLMAuLlJ3Y8Qlw5fJ7F2U1Xh6Z6m6YCajtsIF1VkUhI
 G2dSAigYpe6wU71Faq1KHp9C9VsxlnSR1rc4JOdj9pMoppzkjCphyX3eV9eRcfm4TItTNTGJ
 7DAUQHYS3BVy1fwyuSDIJU/Jrg7WWCEzZkS4sNcBz0/GajYFM7Swybn/VTLtCiioThw4OQIw
 9Afb+3sB9WR86B7N7sSUTvUArknkNDFefTJJLMzEboRMJBWzpR5OAyLxCWwVSQtPp0IdiIC2
 KGF3QXccv/Q9UkI38mWvkilr3EWAOJnPgGCM/521axcyWqXsqNtIxpUAEQEAAcLBZQQYAQIA
 DwUCWfIgkwIbDAUJCWYBgAAKCRC4s7mct4u0M+AsD/47Q9Gi+HmLyqmaaLBzuI3mmU4vDn+f
 50A/U9GSVTU/sAN83i1knpv1lmfG2DgjLXslU+NUnzwFMLI3QsXD3Xx/hmdGQnZi9oNpTMVp
 tG5hE6EBPsT0BM6NGbghBsymc827LhfYICiahOR/iv2yv6nucKGBM51C3A15P8JgfJcngEnM
 fCKRuQKWbRDPC9dEK9EBglUYoNPVNL7AWJWKAbVQyCCsJzLBgh9jIfmZ9GClu8Sxi0vu/PpA
 DSDSJuc9wk+m5mczzzwd4Y6ly9+iyk/CLNtqjT4sRMMV0TCl8ichxlrdt9rqltk22HXRF7ng
 txomp7T/zRJAqhH/EXWI6CXJPp4wpMUjEUd1B2+s1xKypq//tChF+HfUU4zXUyEXY8nHl6lk
 hFjW/geTcf6+i6mKaxGY4oxuIjF1s2Ak4J3viSeYfTDBH/fgUzOGI5siBhHWvtVzhQKHfOxg
 i8t1q09MJY6je8l8DLEIWTHXXDGnk+ndPG3foBucukRqoTv6AOY49zjrt6r++sujjkE4ax8i
 ClKvS0n+XyZUpHFwvwjSKc+UV1Q22BxyH4jRd1paCrYYurjNG5guGcDDa51jIz69rj6Q/4S9
 Pizgg49wQXuci1kcC1YKjV2nqPC4ybeT6z/EuYTGPETKaegxN46vRVoE2RXwlVk+vmadVJlG
 JeQ7iQ==
Message-ID: <d9b1c9b7-ae7b-80df-7b2f-19721f3460cf@akamai.com>
Date:   Fri, 11 Jan 2019 12:41:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111165752.z6e2dfktj2caqi4n@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=920
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901110142
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=952 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901110143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 11:57 AM, Josh Poimboeuf wrote:
> On Fri, Jan 11, 2019 at 05:46:36PM +0100, Alexandre Chartre wrote:
>>
>>
>> On 01/11/2019 04:28 PM, Josh Poimboeuf wrote:
>>> On Fri, Jan 11, 2019 at 01:10:52PM +0100, Alexandre Chartre wrote:
>>>> To avoid any issue with live patching the call instruction, what about
>>>> toggling between two call instructions: one would be the currently active
>>>> call, while the other would currently be inactive but to be used after a
>>>> change is made. You can safely patch the inactive call and then toggle
>>>> the call flow (using a jump label) between the active and inactive calls.
>>>>
>>>> So instead of having a single call instruction:
>>>>
>>>> 	call function
>>>>
>>>> You would have:
>>>>
>>>> 	STATIC_JUMP_IF_TRUE label, key
>>>> 	call function1
>>>> 	jmp done
>>>> label:
>>>> 	call function2
>>>> done:
>>>>
>>>> If the key is set so that function1 is currently called then you can
>>>> safely update the call instruction for function2. Once this is done,
>>>> just flip the key to make the function2 call active. On a next update,
>>>> you would, of course, have to switch and update the call for function1.
>>>
>>> What about the following race?
>>>
>>> CPU1						CPU2
>>> static key is false, doesn't jump
>>> task gets preempted before calling function1
>>> 						change static key to true
>>> 						start patching "call function1"
>>> task resumes, sees inconsistent call instruction
>>>
>>
>> If the function1 call is active then it won't be changed, you will change
>> function2. However, I presume you can still have a race but if the function
>> is changed twice before calling function1:
>>
>> CPU1						CPU2
>> static key is false, doesn't jump
>> task gets preempted before calling function1
>>                                                 -- first function change --
>>                                                 patch "call function2"
>>                                                 change static key to true
>>                                                 -- second function change --
>>                                                 start patching "call function1"
>> task resumes, sees inconsistent call instruction
>>
>> So right, that's a problem.
> 
> Right, that's what I meant to say :-)
> 

could you use something like synchronize_rcu_tasks() between successive
updates to guarantee nobody's stuck in the middle of the call
instruction update? Yes its really slow but the update path is slow anyways.

Thanks,

-Jason

