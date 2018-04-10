Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523370708; cv=none;
        d=google.com; s=arc-20160816;
        b=iq5cKB0ZMa1p8QzcoehpmfmPKsJsHE2lJLeDo2ae6P9eRrn2SuRzkvi++o6Ru8NShO
         ecWDSlUmD/MkYwLoL/H8nFjMo06haftOgZJdRQ7yvhw6W1CrLpwdH47IiWdDtwlPbWlj
         ih1FWEYbdWFngAOBVkp3gqgrU4U0q21gYRsgpSjSuNFJdpCUxuPJwe/yL221gpdfgYoJ
         Y5Fk+2m9vhOfEVAnwJ1RwJdYa8lhh7B0wQoKZr4xwTkDS9yL8u2E7Ew03db0C8um2e7F
         aUM3V9nzm3HU3aPRECraDePjPmyWfDpujXjIvF72lb3g+H68UcPgE9hCgmiFxUIcdHRN
         tngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=xAFqz3hYxlVi7WP8niHI97TWnWs5uwvX53SybrvnRr8=;
        b=T5AYxiAEJPTUmR63f6EtmpYcVR03CpdfnmH6LaMvZgUtOZWtmCQASwbWh1D4swyrYx
         i2lU6/rlyS1J2BuXieJbugYbFMndFQVwyQy0/VI78ydpNZYx9Aysg2UqBwKnPeZbVD+Y
         DyNqhlwNB7fOUJDd6KqrxeJ2LeNzFnWaoXyZwTKOLRsxEQi2Hz2S3oZfeNWKFz5UvT8G
         fb/WUB7vv01IMBUXqQLdL8im84hxY5o4vTDMJ8QMYz8yClII8upabSJcRVCezoUDSocg
         o7l5Tp4KpRBKKzMDNpK6R6A4sI1st0QoAV3gudGUM9ZOdZqiOsU+M3NcewrpeDsYIEgb
         pk8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pKAqEEJc;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pKAqEEJc;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49Sz6esR4O8bA7T8n76HVgbO0d+VlpKWod/Qd0jYX50RuwRCbbr1hJAdel/JrDO8IQUWTM0YQ==
Subject: Re: [PATCH 1/4] xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL
 in pcistub_probe
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, jgross@suse.com,
 gregkh@linuxfoundation.org
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <1523286216-26345-1-git-send-email-baijiaju1990@gmail.com>
 <b07f0a27-f09d-1617-ab9e-ebbc761cb3a4@oracle.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <74fe5dd3-fb85-bed8-82b6-a9fb7a3a376d@gmail.com>
Date: Tue, 10 Apr 2018 22:31:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <b07f0a27-f09d-1617-ab9e-ebbc761cb3a4@oracle.com>
Content-Type: multipart/alternative;
 boundary="------------AF3D0B8D06F849620D9261CF"
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597281379484745930?=
X-GMAIL-MSGID: =?utf-8?q?1597369963486590572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------AF3D0B8D06F849620D9261CF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2018/4/10 22:27, Boris Ostrovsky wrote:
> On 04/09/2018 11:03 AM, Jia-Ju Bai wrote:
>> pcistub_probe() is never called in atomic context.
>> This function is only set as ".probe" in struct pci_driver.
>>
>> Despite never getting called from atomic context,
>> pcistub_probe() calls kmalloc() with GFP_ATOMIC,
>> which does not sleep for allocation.
>> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
>> which can sleep and improve the possibility of sucessful allocation.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>> And I also manually check it.
>>
>> Signed-off-by: Jia-Ju Bai<baijiaju1990@gmail.com>
> What about use of GFP_ATOMIC in pcistub_reg_add()?

Thanks for your reply :)
I find pcistub_reg_add() is called by pcistub_quirk_add().
And pcistub_quirk_add() is called in the macro DRIVER_ATTR().
I am not sure whether DRIVER_ATTR() can make the function called in 
atomic context,
so I do not analyze it in my tool.


Best wishes,
Jia-Ju Bai

--------------AF3D0B8D06F849620D9261CF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018/4/10 22:27, Boris Ostrovsky
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:b07f0a27-f09d-1617-ab9e-ebbc761cb3a4@oracle.com">
      <pre wrap="">On 04/09/2018 11:03 AM, Jia-Ju Bai wrote:
</pre>
      <blockquote type="cite" style="color: #000000;">
        <pre wrap="">pcistub_probe() is never called in atomic context.
This function is only set as ".probe" in struct pci_driver.

Despite never getting called from atomic context,
pcistub_probe() calls kmalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <a class="moz-txt-link-rfc2396E" href="mailto:baijiaju1990@gmail.com" moz-do-not-send="true">&lt;baijiaju1990@gmail.com&gt;</a>
</pre>
      </blockquote>
      <pre wrap="">What about use of GFP_ATOMIC in pcistub_reg_add()?</pre>
    </blockquote>
    <br>
    Thanks for your reply :)<br>
    I find pcistub_reg_add() is called by pcistub_quirk_add().<br>
    And pcistub_quirk_add() is called in the macro DRIVER_ATTR().<br>
    I am not sure whether DRIVER_ATTR() can make the function called in
    atomic context, <br>
    so I do not analyze it in my tool.<br>
    <br>
    <br>
    Best wishes,<br>
    Jia-Ju Bai<br>
  </body>
</html>

--------------AF3D0B8D06F849620D9261CF--
