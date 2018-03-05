Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AG47ELsKoV+q/hW4y2wJIepdNteDw1vrsHbDn9UuNZCVY3RjjwmyHYjd3wHAZPlrmQzWtRF8PBzx
ARC-Seal: i=1; a=rsa-sha256; t=1520282719; cv=none;
        d=google.com; s=arc-20160816;
        b=rdk7v5p0LxeVwRailpogbvqlm+DaFDAmHGST9PesD//s1uwchK51i936BBkccSLaef
         pfNdyLX4J1ImuTFV+97aJYp+JfknVwcMSwbB6SWKXkxwrCYvrelFUOrjYZMytcJfq5SO
         c4t+aSJA6Nc2R266fBezATAEyFCGbYU1DRSTCvi4skkctzk43GiOrezLQU7aM9V8H3bn
         lSIXgXb1mPX1I4MqfvIUv3wmutWjp+H/1BGRp/nedF27vsr9+s5OyANzEqJO81Y1U4bO
         gn4UCagLs1gOVs5teRbLttQFJvMudvh74Yjutz+j/zp9BzulNMcN+A91xcB4XSboWnrN
         czlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=Pw0sdBqKlRsxd8pp1SDHXORSdG5gmA+sykgGPg937dg=;
        b=azfkeN3QkJC7eKAB4kgbnuVymjv7A7VikyyT9q75pR2TwNgIY/L1ZRq9t0fM/zZlN5
         v0WmrKxXljp5+PL69/3mc3IyTS8Sz8s/NDTpCPus8FhiiJkUF6qCdvXUecVxgcidB9uk
         6y2tJRajZFZLo3g6WI/4OfP4puAG1XfWAuRe3932mrjqkbqVmt8Ir5Z2fQwMl/jq7R95
         cSKuy+hXFQEl81Od6la+zijQBmfpgGx3NtZWxjRvRI4LapYw6cI30ePU/9xLzY7oWH6z
         2fUMzMC/Y/b57K6i88mAwc1tTeX0Fv/CbaSJvBiNVrvr3FxLDehoNwbrD+F7aCxjvJVY
         HOdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=g1CfbqTC;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=g1CfbqTC;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v12 09/11] mm: Allow arch code to override copy_highpage()
To: Dave Hansen <dave.hansen@linux.intel.com>, akpm@linux-foundation.org,
        davem@davemloft.net
Cc: kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
        anthony.yznaga@oracle.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
 <68ee1cbc-8e21-e693-7878-777e0d5b0f0c@linux.intel.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <8b441f99-ee41-e113-f52d-dbe0573bf267@oracle.com>
Date: Mon, 5 Mar 2018 13:42:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <68ee1cbc-8e21-e693-7878-777e0d5b0f0c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803050237
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031715838543761?=
X-GMAIL-MSGID: =?utf-8?q?1594131973339609252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 12:24 PM, Dave Hansen wrote:
> On 02/21/2018 09:15 AM, Khalid Aziz wrote:
>> +#ifndef __HAVE_ARCH_COPY_HIGHPAGE
>> +
>>   static inline void copy_highpage(struct page *to, struct page *from)
>>   {
>>   	char *vfrom, *vto;
>> @@ -248,4 +250,6 @@ static inline void copy_highpage(struct page *to, struct page *from)
>>   	kunmap_atomic(vfrom);
>>   }
>>   
>> +#endif
> 
> I think we prefer that these are CONFIG_* options.

I added this mechanism to be same as what we have for copy_user_highpage():

---------------
#ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE

static inline void copy_user_highpage(struct page *to, struct page *from,
         unsigned long vaddr, struct vm_area_struct *vma)
{
----------------

There isn't a CONFIG_* option for copy_user_highpage() so I don't see a 
reason to add one for copy_highpage().

Do you see it differently? In that case, should there be a CONFIG_* 
option for copy_user_highpage() as well?

Thanks,
Khalid
