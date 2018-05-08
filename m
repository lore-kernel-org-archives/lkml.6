Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZqomvHPU4rxUrjfN873kuZbBUoTl99jEoC5ZHeK9d1er7azCKw4HUqt8Iupsnec/u0WOu9W
ARC-Seal: i=1; a=rsa-sha256; t=1525738859; cv=none;
        d=google.com; s=arc-20160816;
        b=HAXItuOJ8wxgL8vudj3LER84mRRNIdVhtEr+oUGjNxIFkAD1Ic3EPyiF1As9KGDY1X
         6Yx3u2zscrYMTRtt1hmJ/lTTOZfykvIxVXZkZ/J/pgDKaIRNQgBCs5llvvl45riOV7ak
         o3AlSvpEjnJ5lNFyKdmBMWDvJBjejOjThxueWR29j1HYnbBe8eYeYBxKJBqkyDxigkrT
         3D992EmUoySnBjba1sjxgcfxowjt/V6jn34klN2FB54iFqvnCrOFpgaxWhcFUU9QHwtz
         jj2tZuvIEODW6R1yPaE+fPKH0rua0WEYlE+jj5d12nj63oFPbe4vUsPL9za4tZyaSxq+
         jsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=pM6N9DgbilLtI3W3eb6mmg+GeWYPHr5/BdLpN8LVmoU=;
        b=lKBOjD4qaQdeifSEKGG/NHjDl26Tfm2nZcgb5AGoSPCh9CSf53ewlS1qGmOFRfpl5w
         cYVNUOs/rnzpS9Po7RDsGd+xjr1PfOcT3DQqAMKU0k0UmvyqupZFRfQNu8HFRKqTG/FL
         h4yvJWq9E/QYuKrDErE7Qf0BGClECrIj0tH+0wqDB+pX4StKDJHsmjRokO20Mef32ZhQ
         YxHqQ6j+CYod3y7FFkLpjt+FoQWOITiHBSUCnhEHPkq7c2Ju6N9VWAU+VsYX0XrSl3Wz
         a63gIpj6hGxV5TWYZ4QirYoAaO+FEUW0Y0jMDLIRM1rL+K6DKpXl88Kq+AGt/VgrKzgv
         xyeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 8 May 2018 00:20:55 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, alexdeucher@gmail.com,
	christian.koenig@amd.com, kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org, hdegoede@redhat.com,
	Kees Cook <keescook@chromium.org>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/9] firmware: print firmware name on fallback path
Message-ID: <20180508002055.GY27853@wotan.suse.de>
References: <20180423201205.20533-1-andresx7@gmail.com>
 <20180423201205.20533-7-andresx7@gmail.com>
 <20180503234235.GX27853@wotan.suse.de>
 <e79fe68b-7dc5-b65a-e483-287c91d67bc2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79fe68b-7dc5-b65a-e483-287c91d67bc2@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569151610038779?=
X-GMAIL-MSGID: =?utf-8?q?1599853150400194494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 10:57:26PM -0400, Andres Rodriguez wrote:
> On 2018-05-03 07:42 PM, Luis R. Rodriguez wrote:
> > On Mon, Apr 23, 2018 at 04:12:02PM -0400, Andres Rodriguez wrote:
> > > Previously, one could assume the firmware name from the preceding
> > > message: "Direct firmware load for {name} failed with error %d".
> > > 
> > > However, with the new firmware_request_nowarn() entrypoint, the message
> > > outlined above will not always be printed.
> > 
> > I though the whole point was to not print an error message. What if
> > we want later to disable this error message? This would prove a bit
> > pointless.
> > 
> > Let's discuss the exact semantics desired here. Why would only the
> > fallback be desirable here?
> > 
> > Andres, Kalle?
> > 
> > After we address this I'll address resubmitting this lat patch
> > along with the last one. For now I'll skip it.
> 
> You are correct. I initially thought it would be useful to know that the
> usermode fallback was being triggered. And for that message to be useful we
> would need a fw name.
> 
> But now that you point it out, this behaviour is inconsistent with the
> _nowarn() definition. We shouldn't have a message in the first place.
> 
> So it might be better to instead have:
> 
> if (!(opt_flags & FW_OPT_NO_WARN) )
>     dev_warn(device, "Falling back to user helper\n");
> 
> No need to add the firmware name, cause we either:
>     a) FW_OPT_NO_WARN is set and no messages are printed, or
>     b) FW_OPT_NO_WARN is not set and we get both messages.
> 
> Yay, nay?

I welcome such a new warning but not for any of the reasons stated.

It make sense if FW_OPT_NO_WARN is not set and only because the fallback
mechanism can fail for a slew of different firmware files, and just getting
informed a failure with a fallback occurred does not tell us for which file it
failed for.

I'll add such a patch to my queue and send it off soon prior to your own
new API nowarn call.

  Luis
