Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AB8JxZoD0VncV0aQYTiRHp0Dlz9UhEO1i7X7ktbboO2jyWoWElXpQ+dYyzecWHUA+XxXoI9TYBeu
ARC-Seal: i=1; a=rsa-sha256; t=1525689348; cv=none;
        d=google.com; s=arc-20160816;
        b=kO7fWtKJNxafCy+4267ElN7EAVSFCQrGcOLv6BR9O7zqcF9hjZrX5aT5BoTekt0/Ju
         6ymaXDpIyPyMfJuiuTTjGjYvWjlM5PrckJpH0EH9FDXSV6RthASEfwG2dFVaUwuttDjn
         Qdd+AwZfwpK+r89Vav0rPaGm8qmDA8S3dXCwE2jN3P/sorZPN93tiTQ5GzpPmZW1eZzi
         hHCPOnwIlQmBMyqWec6dPY/Nc/SLJjE517aQty8XJsD5rZTX/+zXSXTo/804+qKa7khD
         S+Adnck9+TGR1r+6P9MUeuwIhjmgIod6MhA5Ml+WPKjCmqif3wpKP9nRhwP/wtM2byU2
         59ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=DXVlQTmUYghztDr+SLfAd1jckUjmZ0NF/GwGboHeNtg=;
        b=WZHamFMN33wr6Z4b+nuuFXFIVhGPvljalmwdGBQblWihYWZfKmb+nDzSyi48YUnlKH
         c7i+9i2DUXOgfbuff0DGriK1XLW3HKr8XiB83JX2n9AUI4F7+vyEJHdpCn38FOybQ4Zs
         LDZcSvccEtDUaaN7tX7fXqfmms6Eso4d/JiyhPXgbKs++vu7aq/J/FHM7Hd8hNxFQxTT
         VrI6GuuSvaSN+X19mWAt78nL29MZeckN8+Q+qSpGnK+yGxRLiRinBmej5WsHp5ZZ3hpV
         nsnZsMc6rYCnH6E+/D+mD6V4J1nYXvGTMI1cgwiTv9xuNusN8HBWoneSGUOLxIg/6N8P
         dhNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.11.71.1 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.11.71.1 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 08/15] powerpc/powernv: implement opal_put_chars_atomic
In-Reply-To: <20180501203721.7b60fcd8@roar.ozlabs.ibm.com>
References: <20180430145558.4308-1-npiggin@gmail.com> <20180430145558.4308-9-npiggin@gmail.com> <1525168138.2325.100.camel@kernel.crashing.org> <20180501203721.7b60fcd8@roar.ozlabs.ibm.com>
Date: Mon, 07 May 2018 20:35:42 +1000
Message-ID: <87zi1bbvnl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183467019394764?=
X-GMAIL-MSGID: =?utf-8?q?1599801234262766729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Tue, 01 May 2018 19:48:58 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> On Tue, 2018-05-01 at 00:55 +1000, Nicholas Piggin wrote:
>> > The RAW console does not need writes to be atomic, so relax
>> > opal_put_chars to be able to do partial writes, and implement an
>> > _atomic variant which does not take a spinlock. This API is used
>> > in xmon, so the less locking that is used, the better chance there
>> > is that a crash can be debugged.  
>> 
>> Same comment I already had :-) "atomic" in Linux tends to mean
>> something else (ie, atomic context), so I'd rather have something
>> like opal_put_chars_sync() or such...
>
> Oh yeah, I didn't ignore you, just... I thought atomic was okay.
> atomic *also* tends to mean happens atomically. I think the in
> atomic context meaning actually tends to be inatomic.
>
> Sync I actually thought could be more easily confused with
> synchronous vs asynchronous here.

I think we probably want opal_put_chars() to stay as it is.

And then add a variant for the call (just xmon?) that want lock free
behaviour.

opal_put_chars_unlocked() or something?

cheers
