Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+fdrx1vvtvctkCmnzz/GjvGe2QA7WJIh9jBFepmGpp6MBBqSpW1+5dNrcuPYJaN8l6oHqA
ARC-Seal: i=1; a=rsa-sha256; t=1523472995; cv=none;
        d=google.com; s=arc-20160816;
        b=Ea4+q2zbHWmiyjzYlxXiDPfpbzSc3LIiuRXjqPADJlNLPIbn6Q4oBKbcaNLbF7rcKJ
         bLjV97ZsCI5ff57uTYuniYewogUg3hAXyo+bnxE/DGWPb59fBFIMtL8r9RS+Y+478NGv
         VAePcLNCx0mAAwnIBZn2xF4IymxP0MIHXtzrXz9jKSxFRJao6yi+nJBwWMv104T6zO9H
         3OahSLtM0ijEyrXUuSOGENh9vCH9yjgWoFTjRgB3T/152yPKq3ZborhxGAh50dT8hrDQ
         4nJkI8QoMMoA7mz1Kd3r3yribYyILcASp+oZ6hbkvT8iU7tchqC7H9mcXG5PqnoYVmk6
         /0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CSsqSKSB7K4GzPEihdOSeT2Ls4h8RYxGgluPMvcsTKQ=;
        b=QtrwNMtJhSsmZRrkgJuNdx1xPw88ndKh33fyjhYNWivbuy74hwCJTssMchnQbwbW56
         lyXieIWBsvaUPzXE3MQ33R+WhLqd+q7g1HIDTZAmKZI0BTBzt0bQiggL6fOOe2cEThBt
         x85gWmzdMCCeIa2+doYCDxE3xZtg7saEmrpy/jFzzWsEKzpY4O4QfCyHdOMMXl7JzCCp
         SvrkWUSz+nwchJkvA1syFAL/6egGlTqArxiOA+8m0RRcefL5Xnip3dVXOFWfRgbQLw+b
         ZebYXvwU98SDbD55qvMPrY8n05QX7XCEpElWG+/hPr9h0+0mb3ZciYwmGQF5XhsvlJ6V
         Xn6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tin Huynh <tnhuynh@apm.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 091/310] leds: pca955x: Correct I2C Functionality
Date: Wed, 11 Apr 2018 20:33:50 +0200
Message-Id: <20180411183626.163219534@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476134288988698?=
X-GMAIL-MSGID: =?utf-8?q?1597477219267080603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tin Huynh <tnhuynh@apm.com>


[ Upstream commit aace34c0bb8ea3c8bdcec865b6a4be4db0a68e33 ]

The driver checks an incorrect flag of functionality of adapter.
When a driver requires i2c_smbus_read_byte_data and
i2c_smbus_write_byte_data, it should check I2C_FUNC_SMBUS_BYTE_DATA
instead I2C_FUNC_I2C.
This patch fixes the problem.

Signed-off-by: Tin Huynh <tnhuynh@apm.com>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/leds-pca955x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -266,7 +266,7 @@ static int pca955x_probe(struct i2c_clie
 			"slave address 0x%02x\n",
 			id->name, chip->bits, client->addr);
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C))
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
 	if (pdata) {
