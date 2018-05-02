Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AB8JxZq2jJ3ROlTaowIrv0204TiQmjS589svmDllKQ+jq/dwF9WaeFv+HrmR4bOxo5J8HX8J2cwh
ARC-Seal: i=1; a=rsa-sha256; t=1525220365; cv=none;
        d=google.com; s=arc-20160816;
        b=G7Rfhuw8sumAD9/FLxH/NlarIpKJ3UBIYvlxApSN32EeudT0w1B/X4+AJViA/rKLp7
         Ve+8Mq8PWsKLc3M/VVzcNjASIiKBhxl2JBv1SJPNhG9FW3Vw/s806kJ6PoCQUAfYTvB8
         TA9ahYfxgtwvM3wsGrzneIOls6YxzzgebXZ3l3FzyzB/XpeLh9B8IK4PtC3MBViU/B0C
         jWiOxlCJ8FwgT6WUg2AnFjt+jfu0npNkU+3hbnvZLjSZp+rlouHJ4FZvqfdySJFgOoWe
         usJFfHpTGpYdqaXEOCpSB56ndL10/77Gdngo+7Rbm5oQ0g9RYMb0QsLPgECa5HHZm369
         kq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=x1TmdzjGMRoATkCl5MFDlmNDH1ATg7+vMQq9qRb7ZR4=;
        b=sVVtOkOScqj287TfHfKKPeH/ntwx6OdjPnWnp4C7/h7joDvbhB6ou0wWh5OU4tjQJy
         XBsit1CCPYPpwcTl7p3Slc04NWs7uMmZeysx1KvkYLtCmWq9dQ+zWaEEi4TSWiwm7uFd
         w+y5VxGx/X79j4J2MqD4McZbZeDUy7JqUWmkkjGtL+jdE9xN4sHkthXj/QrwMFACheL+
         PfMLmTUvQSXujzhVCbdubOJvfXjwqkia3z4oYa0fxbVymN5W2Gs6o+Y3fyHMP3zYL2Xv
         tqeXD6JDSn0q5p5gnOa0kdM4TmJbIseARHzh31stfIYUKarrZmtyLYdvWB7nBoQX0mdS
         up1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=jVsfs9ts;
       spf=pass (google.com: domain of tytso@thunk.org designates 74.207.234.97 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=jVsfs9ts;
       spf=pass (google.com: domain of tytso@thunk.org designates 74.207.234.97 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Tue, 1 May 2018 20:19:21 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] random: Return nbytes filled from hw RNG
Message-ID: <20180502001921.GB24100@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	"Tobin C. Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
 <1525217620-4107-3-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525217620-4107-3-git-send-email-me@tobin.cc>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306642017406992?=
X-GMAIL-MSGID: =?utf-8?q?1599309469628063521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 09:33:39AM +1000, Tobin C. Harding wrote:
> Currently the function get_random_bytes_arch() has return value 'void'.
> If the hw RNG fails we currently fall back to using get_random_bytes().
> This defeats the purpose of requesting random material from the hw RNG
> in the first place.
> 
> There are currently no intree users of get_random_bytes_arch().
> 
> Only get random bytes from the hw RNG, make function return the number
> of bytes retrieved from the hw RNG.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Acked-by: Theodore Ts'o <tytso@mit.edu>
