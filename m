Return-Path: <rodrigosiqueiramelo@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521208792; cv=none;
        d=google.com; s=arc-20160816;
        b=wo9OWsdVo+lROCsPntLwcozF3sh3NpH3oJf9AlitKQt/w2q402sQsZOtw64vqxWEPi
         /Q2D3cWrac9+CXYUvqNmHqF73Mg+tXixlb6/FwzHjGTcjv81PGPECcYwXLxdDTfmgj0C
         YUVvfVDKCovsglHZ+/Pyg9aRJCqzy1TTBiRAjKdxUr7KjQEZC7p52n4QvTPEqbrei8D/
         b229TtbRBkJPCJsvtvOTT+mWBcPdiR5r1wrVaLuj7IxcD6hZYbtu6hSw//xTTVFVUKHM
         FbyJtXe6tEO4azaZG/zM7xUcLHxMQdQ7YnxF9p5TJ1kivAefaltzq2eM00yJ51Zk7wBm
         56KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=DojbVugGgHZ5ebFbQCWiJRRqH+HufibboIf7JLTnbm0=;
        b=YxsOQBaYgI+OzQfmGmA8cMzRjxzOESOiJo/hKn+hM9qexeMatqK6pl4RW6h/dg/4Mw
         xZoevNgAWWq/39NHxvKNSasSAsqksaenQtCq3olpoAOQJFHNNBJqGi1jcagmwEhuRXyq
         W+BBmD0s/fooiJPZ4AgLLgGoUfxw60XTwTXsAVcc676X/MnF794SUUt6Y31uT8Idznbd
         LZcs1z7lHjMfIqeOyHthKFwvE4WMlgA2RFpcmk/DncO+QVfH8f56TReQTsfAThzV1f9X
         5EoKCyNnIoUS+7lnzzW9ErhZpZN3zqEKHR/KRO/afj6uIq5mpk2RjVijzUmX1k+lZUwm
         jDDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CfklRfdO;
       spf=pass (google.com: domain of rodrigosiqueiramelo@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rodrigosiqueiramelo@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CfklRfdO;
       spf=pass (google.com: domain of rodrigosiqueiramelo@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rodrigosiqueiramelo@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvx7deRkHyfbUufFYg5B/Uw7Q8eTnABU9ZfvlbV6rQUKbEajOGuDuDjHalgPqcRFEBcArVWrA==
Date: Fri, 16 Mar 2018 10:59:46 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 7/7] staging:iio:ade7854: Add proper error handling
 condition
Message-ID: <20180316135946.b7elcisgkfs4ibwy@smtp.gmail.com>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <20180315121115.iwkx2dfikgpjeeec@mwanda>
 <20180316002800.mvy75in42y5j2dpz@smtp.gmail.com>
 <20180316080257.dlglfjespmltwo3u@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316080257.dlglfjespmltwo3u@mwanda>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594937723243519644?=
X-GMAIL-MSGID: =?utf-8?q?1595103031062074445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16, Dan Carpenter wrote:
> You're right that there is a bug but this is not the right fix.
> 
> The ade7854_i2c_write_reg_32() function returns 6 on success which makes
> no sense.  It should be zero or negative error codes.  All the write_reg
> functions in drivers/staging/iio/meter/ade7854-i2c.c have the same bug.
> 
> Please, fix that instead and leave ade7854_initial_setup() alone.

I see. However, I think the following steps could be better:

1) Update ade7854_i2c_write_reg() in order to return 0

The primary objective of this patchset it removes the duplications
related to write_reg_* and read_reg_*. As a result, in the first patch
create the function ade7854_i2c_write_reg(). I will add the following
code to fix the problem that we are discussing:

ade7854_i2c_write_reg() {
...
ret = i2c_master_send(st->i2c, st->tx, count);
...
return ret < 0 ? ret : 0;
}

With this, I do not need to touch any of the
ade7854_i2c_write_reg_(8|16|24|32) functions. 

2) Drop out the last patch from the patchset

Is that ok? If so, I will send the V2 today.
 
> regards,
> dan carpenter
> 
